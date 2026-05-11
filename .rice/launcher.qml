import Quickshell
import QtQuick
import QtQuick.Layouts

ShellRoot {
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


    PanelWindow {
        id: topLevel
        anchors.top: true
        anchors.left: true
        anchors.right: true
        height: 0
        color: "transparent"

        PopupWindow {
            anchor.window: topLevel
            anchor.rect.x: parentWindow.width / 2 - width / 2
            anchor.rect.y: parentWindow.height + 100
            width: 500
            height: 500
            visible: true
            color: "transparent"

            Rectangle {
                anchors.centerIn: parent
                width: 500
                height: 500
                color: root.colBg
                radius: 32

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8

                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        color: "red"
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 50
                    }

                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        color: "green"
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 50
                    }

                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        color: "blue"
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 50
                    }
                }
            }
        }
    }
}
