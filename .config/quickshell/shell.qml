import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower
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
    property color colGreen: "#9ece6a"
    property string fontFamily: "Hack Nerd Font"
    property int fontSize: 16

    // System data
    property string wifiNetwork: "None"
    property int niriWorkspaceNum: -1
    property int niriWorkspaceCount: -1
    property string niriWindowName: "None"
    property int cpuUsage: 0
    property int memUsage: 0
    property int batLevel: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    // Niri Current Workspace Num Process
    Process {
        id: niriWorkspaceNumProc
        command: ["sh", "-c", "niri msg workspaces | grep \"*\" | cut -d \" \" -f 3"]
        stdout: StdioCollector {
            onStreamFinished: {
                if (!text)
                    return;
                var lines = text.trim().split("\n");
                var firstLine = lines[0]; // There should only be one line
                root.niriWorkspaceNum = firstLine;
            }
        }
        Component.onCompleted: running = true
    }

    // Niri Workspace Count Process
    Process {
        id: niriWorkspaceCountProc
        command: ["sh", "-c", "niri msg workspaces | wc -l"]
        stdout: StdioCollector {
            onStreamFinished: {
                if (!text)
                    return;
                var lines = text.trim().split("\n");
                var firstLine = lines[0]; // There should only be one line
                root.niriWorkspaceCount = firstLine;
                root.niriWorkspaceCount = root.niriWorkspaceCount - 1;
            }
        }
        Component.onCompleted: running = true
    }

    // Niri Window Name Process
    Process {
        id: niriWindowNameProc
        command: ['sh', '-c', 'basename $(niri msg focused-window | grep "App ID:" | cut -d ":" -f 2 | tr -d \\" | tr . /)']
        stdout: StdioCollector {
            onStreamFinished: {
                if (!text)
                    return;
                var lines = text.trim().split("\n");
                var firstLine = lines[0]; // There should only be one line
                root.niriWindowName = firstLine;
            }
        }
        Component.onCompleted: running = true
    }

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
                root.wifiNetwork = lines[0];
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
                if (root.lastCpuTotal > 0) {
                    root.cpuUsage = Math.round(100 * (1 - (idle - root.lastCpuIdle) / (total - root.lastCpuTotal)));
                }
                root.lastCpuTotal = total;
                root.lastCpuIdle = idle;
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
                root.memUsage = Math.round(100 * used / total);
            }
        }
        Component.onCompleted: running = true
    }

    // Super Fast timer
    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            niriWorkspaceNumProc.running = true;
            niriWorkspaceCountProc.running = true;
            niriWindowNameProc.running = true;
        }
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
            wifiProc.running = true;
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
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
        RowLayout {
            id: leftSection
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            // Niri Workspaces
            Text {
                text: root.niriWorkspaceNum + " / " + root.niriWorkspaceCount
                color: root.colCyan
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }

            Rectangle {
                Layout.preferredWidth: 1
                Layout.preferredHeight: 16
                color: root.colMuted
            }

            // Niri Window Name
            Text {
                text: root.niriWindowName
                color: root.colBlue
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }
        }

        // Center
        Item {
            anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height

            // Clock
            Text {
                anchors.centerIn: parent

                text: Qt.formatDateTime(clock.date, "hh:mm AP - ddd MMM dd")
                color: root.colBlue
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }
        }

        // Right Side
        RowLayout {
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
                text: "  " + root.wifiNetwork
                color: root.colBlue
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }

            Rectangle {
                Layout.preferredWidth: 1
                Layout.preferredHeight: 16
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
                Layout.preferredWidth: 1
                Layout.preferredHeight: 16
                color: root.colMuted
            }

            // Cpu
            Text {
                text: " " + root.cpuUsage + "%"
                color: root.colYellow
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }

            Rectangle {
                Layout.preferredWidth: 1
                Layout.preferredHeight: 16
                color: root.colMuted
            }

            // Memory
            Text {
                text: " " + root.memUsage + "%"
                color: root.colCyan
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }

            Rectangle {
                Layout.preferredWidth: 1
                Layout.preferredHeight: 16
                color: root.colMuted
            }

            // Battery
            Text {
                text: {
                    let batPercent = UPower.displayDevice.percentage * 100;
                    let chargingIcon = "";

                    if (UPower.displayDevice.state == 4) {
                        chargingIcon = " ";
                    }

                    if (batPercent < 5.0) {
                        return chargingIcon + " " + batPercent + "%";
                    } else if (batPercent < 25.0) {
                        return chargingIcon + " " + batPercent + "%";
                    } else if (batPercent < 50.0) {
                        return chargingIcon + " " + batPercent + "%";
                    } else if (batPercent < 75.0) {
                        return chargingIcon + " " + batPercent + "%";
                    } else {
                        return chargingIcon + " " + batPercent + "%";
                    }
                }

                color: root.colGreen
                font {
                    family: root.fontFamily
                    pixelSize: root.fontSize
                    bold: true
                }
            }
        }
    }
}
