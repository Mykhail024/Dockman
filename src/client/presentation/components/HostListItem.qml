import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick

import Dockman.Theme

Item {
    id: root

    width: ListView.view.width
    height: 45

    required property string name;
    required property string address;
    required property int port;
    required property bool connected;

    Rectangle {
        anchors.fill: parent
        color: "white" 
        opacity: mouseArea.containsMouse ? 0.05 : 0.0
        radius: Borders.radiusSm

        Behavior on opacity {
            NumberAnimation { duration: Transitions.durationFast; easing: Easing.InQuad }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Spacing.marginSm
        anchors.rightMargin: Spacing.marginSm

        spacing: Spacing.space2

        Image {
            id: icon

            Layout.alignment: Qt.AlignVCenter
            Layout.preferredHeight: 18
            Layout.preferredWidth: 18

            source: "qrc:/resources/icons/server.svg"
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
            visible: false
        }

        MultiEffect {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredHeight: 18
            Layout.preferredWidth: 18

            source: icon
            colorization: 1.0
            colorizationColor: mouseArea.containsMouse ? Colors.foreground : Colors.mutedForeground

            Behavior on colorizationColor {
                ColorAnimation { duration: Transitions.durationFast; easing: Easing.InQuad }
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter
            spacing: 0

            Text {
                text: root.name
                color: mouseArea.containsMouse ? Colors.foreground : Colors.mutedForeground
                font.pixelSize: Typography.sizeBase
                // opacity: enabled ? 1.0 : 0.4

                // Behavior on opacity {
                //     NumberAnimation { duration: Transitions.durationFast; easing: Easing.InQuad }
                // }

                Behavior on color {
                    ColorAnimation { duration: Transitions.durationFast; easing: Easing.InQuad }
                }
            }
            Text {
                text: root.address + ":" + root.port
                font.pixelSize: Typography.sizeXs
                color: Colors.mutedForeground
            }
        }

        Item { Layout.fillWidth: true }

        Rectangle {
            Layout.preferredWidth: 10
            Layout.preferredHeight: 10
            radius: width / 2

            color: root.connected ? Colors.primary : "gray"
        }
    }
}
