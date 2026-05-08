import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    // Theme
    property color colBg: "#181825"
    property color colFg: "#a9b1d6"
    property color colMuted: "#444b6a"
    property color colCyan: "#0db9d7"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"
    property string fontFamily: "Hack Nerd Font"
    property int fontSize: 16

    // System data
    property string wifiNetwork: "None"
    property int cpuUsage: 0
    property int memUsage: 0
    property int batLevel: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    // Wifi Process
    // Uses NetworkManager
    Process {
        id: wifiProc
        // command: ["sh", "-c", "nmcli -c no -t -f NAME connection"]
        command: ["sh", "-c", "nmcli"]
        stdout: StdioCollector {
            onStreamFinished: {
                if (!text)
                    return;
                var lines = text.trim().split("\n");
                wifiNetwork = lines[0];
            }
        }
        Component.onCompleted: running = true
    }

    // CPU Process
    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var p = data.trim().split(/\s+/);
                var idle = parseInt(p[4]) + parseInt(p[5]);
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0);
                if (lastCpuTotal > 0) {
                    cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)));
                }
                lastCpuTotal = total;
                lastCpuIdle = idle;
            }
        }
        Component.onCompleted: running = true
    }

    // Memory Process
    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var total = parseInt(parts[1]) || 1;
                var used = parseInt(parts[2]) || 0;
                memUsage = Math.round(100 * used / total);
            }
        }
        Component.onCompleted: running = true
    }

    // Battery Process
    Process {
        id: batProc
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT0/capacity"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                batLevel = data;
            }
        }
        Component.onCompleted: running = true
    }

    // Faster timer
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true;
            memProc.running = true;
        }
    }

    // Slower timer
    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            batProc.running = true;
            wifiProc.running = true;
        }
    }

    // Pipewire
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    anchors.top: true
    anchors.left: true
    anchors.right: true

    implicitHeight: 30
    color: root.colBg

    //////////////////////////// Bar elements layout ///////////////////////////
    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        Item {
            Layout.fillWidth: true
        }

        // Left Side
        Row {
            id: leftSection
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8
        }

        // Center
        Item {
            anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height

            // Clock
            Text {
                id: clock
                anchors.centerIn: parent

                text: Qt.formatDateTime(new Date(), "HH:mm - ddd, MMM, dd")
                color: root.colBlue
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: clock.text = Qt.formatDateTime(new Date(), "hh:mm AP - ddd, MMM dd")
                }
            }
        }

        // Right Side
        Row {
            id: rightSection
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            // System Tray
            Repeater {
                model: SystemTray.items

                MouseArea {
                    id: trayDelegate
                    required property SystemTrayItem modelData

                    Accessible.role: Accessible.Button
                    Accessible.name: modelData.tooltipTitle || modelData.title || "System tray item"

                    Layout.preferredWidth: 24
                    Layout.preferredHeight: 24

                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton) {
                            modelData.activate();
                        } else if (mouse.button === Qt.RightButton) {
                            if (modelData.hasMenu) {
                                menuAnchor.open();
                            }
                        } else if (mouse.button === Qt.MiddleButton) {
                            modelData.secondaryActivate();
                        }
                    }

                    IconImage {
                        anchors.centerIn: parent
                        source: trayDelegate.modelData.icon
                        implicitSize: 16
                    }

                    QsMenuAnchor {
                        id: menuAnchor
                        menu: trayDelegate.modelData.menu

                        anchor.window: trayDelegate.QsWindow.window
                        anchor.adjustment: PopupAdjustment.Flip
                        anchor.onAnchoring: {
                            const window = trayDelegate.QsWindow.window;
                            const widgetRect = window.contentItem.mapFromItem(trayDelegate, 0, trayDelegate.height, trayDelegate.width, trayDelegate.height);
                            menuAnchor.anchor.rect = widgetRect;
                        }
                    }
                }
            }

            // Wifi
            Text {
                text: "  " + wifiNetwork
                color: root.colBlue
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }

            Rectangle {
                width: 1
                height: 16
                color: root.colMuted
            }

            // Sound
            Text {
                text: {
                    const sink = Pipewire.defaultAudioSink;
                    return "  " + Math.round(sink.audio.volume * 100) + "%";
                }
                color: root.colCyan
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }

            Rectangle {
                width: 1
                height: 16
                color: root.colMuted
            }

            // Cpu
            Text {
                text: " " + cpuUsage + "%"
                color: root.colYellow
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }

            Rectangle {
                width: 1
                height: 16
                color: root.colMuted
            }

            // Memory
            Text {
                text: " " + memUsage + "%"
                color: root.colCyan
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }

            Rectangle {
                width: 1
                height: 16
                color: root.colMuted
            }

            // Battery
            Text {
                text: " " + batLevel + "%"
                color: root.colYellow
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }
        }
    }
}
