// vim:foldmethod=marker

import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Services.Notifications
import Quickshell.Services.Pipewire
import Quickshell.Services.Pam
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "./Theme.qml"

ShellRoot {
    id: root

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

    //////////////////////////////////// Processes and Timers {{{
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
    // }}}

    //////////////////////////////////// Status Bar {{{
    PanelWindow {

        anchors.top: true
        anchors.left: true
        anchors.right: true

        implicitHeight: 30
        color: Theme.colBg

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
                    color: Theme.colCyan
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSize
                        bold: true
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 1
                    Layout.preferredHeight: 16
                    color: Theme.colMuted
                }

                // Niri Window Name
                Text {
                    text: root.niriWindowName
                    color: Theme.colBlue
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSize
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
                    color: Theme.colBlue
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSize
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
                    color: Theme.colBlue
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSize
                        bold: true
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 1
                    Layout.preferredHeight: 16
                    color: Theme.colMuted
                }

                // Sound
                Text {
                    text: {
                        const sink = Pipewire.defaultAudioSink;
                        return "  " + Math.round(sink.audio.volume * 100) + "%";
                    }
                    color: Theme.colCyan
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSize
                        bold: true
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 1
                    Layout.preferredHeight: 16
                    color: Theme.colMuted
                }

                // Cpu
                Text {
                    text: " " + root.cpuUsage + "%"
                    color: Theme.colYellow
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSize
                        bold: true
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 1
                    Layout.preferredHeight: 16
                    color: Theme.colMuted
                }

                // Memory
                Text {
                    text: " " + root.memUsage + "%"
                    color: Theme.colCyan
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSize
                        bold: true
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 1
                    Layout.preferredHeight: 16
                    color: Theme.colMuted
                }

                // Battery
                Text {
                    text: {
                        let batPercent = Math.round(UPower.displayDevice.percentage * 100);
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

                    color: Theme.colGreen
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSize
                        bold: true
                    }
                }
            }
        }
    }
    // }}}

    //////////////////////////////////// Lock Screen {{{
    Scope {
        id: rootLock

        property string currentText: ""
        property bool unlockInProgress: false
        property bool showFailure: false

        // Clear the failure text once the user starts typing.
        onCurrentTextChanged: showFailure = false

        function tryUnlock() {
            if (currentText === "")
                return;

            rootLock.unlockInProgress = true;
            pam.start();
        }

        IpcHandler {
            target: "lock"

            function lockScreen(): void {
                lock.locked = true;
            }
        }

        Process {
            id: niriPowerOffMonitorsProc
            command: ["sh", "-c", "niri msg action power-off-monitors"]
        }

        IdleMonitor {
            enabled: true
            respectInhibitors: true
            timeout: 60 * 5 // Seconds

            onIsIdleChanged: {
                if (lock.locked == false) {
                    lock.locked = true;
                }
                niriPowerOffMonitorsProc.running = true;
            }
        }

        PamContext {
            id: pam

            // pam_unix will ask for a response for the password prompt
            onPamMessage: {
                if (this.responseRequired) {
                    this.respond(rootLock.currentText);
                }
            }

            // pam_unix won't send any important messages so all we need is the completion status.
            onCompleted: result => {
                if (result == PamResult.Success) {
                    lock.locked = false;
                } else {
                    rootLock.currentText = "";
                    rootLock.showFailure = true;
                }

                rootLock.unlockInProgress = false;
            }
        }

        WlSessionLock {
            id: lock

            // Session can be locked immediately when quickshell starts
            locked: false

            WlSessionLockSurface {
                color: Theme.colBg

                RowLayout {
                    visible: Window.active
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.verticalCenter

                    // Uncomment to bypass without using password
                    // Button {
                    //     text: "UNLOCK ME"
                    //     onClicked: lock.locked = false
                    // }

                    TextField {
                        id: passwordBox

                        visible: false // Keep the field invisible
                        implicitWidth: 400
                        padding: 10
                        color: "black"

                        focus: true
                        enabled: !rootLock.unlockInProgress
                        echoMode: TextInput.Password
                        inputMethodHints: Qt.ImhSensitiveData
                        onTextChanged: {
                            rootLock.currentText = this.text;
                            passwordDots.count = rootLock.currentText.length;
                        }
                        onAccepted: rootLock.tryUnlock()

                        // Update the text in the box to match the text in the context.
                        // This makes sure multiple monitors have the same text.
                        Connections {
                            target: rootLock

                            function onCurrentTextChanged() {
                                passwordBox.text = rootLock.currentText;
                            }
                        }
                    }

                    // Password Dots
                    Row {
                        spacing: 10

                        Repeater {
                            id: passwordDots
                            property int count: 0
                            model: count

                            Rectangle {
                                width: 40
                                height: 40
                                radius: 10
                                color: Theme.colMuted
                            }
                        }
                    }

                    Text {
                        text: "Incorrect password"
                        visible: rootLock.showFailure
                        color: Theme.colYellow
                        font {
                            family: Theme.fontFamily
                            pixelSize: 20
                            bold: true
                        }
                    }
                }
            }
        }
    }
    // }}}

    //////////////////////////////////// Notifications {{{
    Scope {
        id: rootNotifications
        property bool shouldShowNotifications: false

        NotificationServer {
            id: notificationServer
            bodySupported: true
            imageSupported: true
            bodyHyperlinksSupported: true
            bodyMarkupSupported: true

            onNotification: notification => {
                notification.tracked = true;
                rootNotifications.shouldShowNotifications = true;
                hideTimerNotifications.restart();
                // console.log(notification.summary);
            }
        }

        Timer {
            id: hideTimerNotifications
            interval: 5000
            onTriggered: rootNotifications.shouldShowNotifications = false
        }

        LazyLoader {
            active: rootNotifications.shouldShowNotifications

            PanelWindow {
                anchors.top: true
                anchors.right: true
                exclusiveZone: 0
                implicitWidth: 400
                implicitHeight: Screen.height
                color: "transparent"
                mask: Region {} // An empty click mask prevents the window from blocking mouse events.

                // Stack notificatons on top of each other
                ListView {
                    anchors {
                        fill: parent
                        topMargin: 10
                        bottomMargin: 10
                        leftMargin: 10
                        rightMargin: 10
                    }
                    spacing: 5
                    model: notificationServer.trackedNotifications

                    delegate: Rectangle {
                        width: parent.width
                        height: 200
                        radius: 15
                        color: Theme.colBg

                        ColumnLayout {
                            spacing: 5

                            Text {
                                Layout.topMargin: 10
                                Layout.leftMargin: 10
                                Layout.rightMargin: 10
                                Layout.maximumWidth: 365
                                text: modelData.appName
                                wrapMode: Text.Wrap
                                maximumLineCount: 6
                                elide: Text.ElideRight
                                color: Theme.colBlue
                                font {
                                    family: Theme.fontFamily
                                    pixelSize: Theme.fontSize
                                }
                            }

                            Text {
                                Layout.leftMargin: 10
                                Layout.rightMargin: 10
                                Layout.maximumWidth: 365
                                text: modelData.summary
                                wrapMode: Text.Wrap
                                maximumLineCount: 6
                                elide: Text.ElideRight
                                color: Theme.colYellow
                                font {
                                    family: Theme.fontFamily
                                    pixelSize: Theme.fontSize
                                }
                            }

                            Text {
                                Layout.bottomMargin: 10
                                Layout.leftMargin: 10
                                Layout.rightMargin: 10
                                Layout.maximumWidth: 365
                                text: modelData.body
                                wrapMode: Text.Wrap
                                maximumLineCount: 6
                                elide: Text.ElideRight
                                color: Theme.colCyan
                                font {
                                    family: Theme.fontFamily
                                    pixelSize: Theme.fontSize
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    // }}}

    //////////////////////////////////// OSD {{{
    Scope {
        id: rootOsd

        // Bind the pipewire node so its volume will be tracked
        PwObjectTracker {
            objects: [Pipewire.defaultAudioSink]
        }

        Connections {
            target: Pipewire.defaultAudioSink?.audio

            function onVolumeChanged() {
                rootOsd.shouldShowOsd = true;
                hideTimer.restart();
            }
        }

        property bool shouldShowOsd: false

        Timer {
            id: hideTimer
            interval: 1000
            onTriggered: rootOsd.shouldShowOsd = false
        }

        LazyLoader {
            active: rootOsd.shouldShowOsd

            PanelWindow {
                anchors.bottom: true
                margins.bottom: screen.height / 5
                exclusiveZone: 0

                implicitWidth: 400
                implicitHeight: 50
                color: "transparent"

                // An empty click mask prevents the window from blocking mouse events.
                mask: Region {}

                Rectangle {
                    anchors.fill: parent
                    radius: height / 2
                    color: Theme.colBg

                    RowLayout {
                        anchors {
                            fill: parent
                            leftMargin: 10
                            rightMargin: 15
                        }
                        spacing: 15

                        Text {
                            text: " "
                            font {
                                family: Theme.fontFamily
                                pixelSize: 24
                                bold: true
                            }
                            color: Theme.colCyan
                        }

                        Rectangle {
                            // Stretches to fill all left-over space
                            Layout.fillWidth: true

                            implicitHeight: 10
                            radius: 20
                            color: Theme.colMuted

                            Rectangle {
                                anchors {
                                    left: parent.left
                                    top: parent.top
                                    bottom: parent.bottom
                                }

                                implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                                radius: parent.radius
                                color: Theme.colCyan
                            }
                        }

                        Text {
                            text: {
                                const sink = Pipewire.defaultAudioSink;
                                return Math.round(sink.audio.volume * 100);
                            }
                            font {
                                family: Theme.fontFamily
                                pixelSize: 24
                                bold: true
                            }
                            color: Theme.colCyan
                        }
                    }
                }
            }
        }
    }
    // }}}
}
