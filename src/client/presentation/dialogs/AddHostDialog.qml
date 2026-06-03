import QtQuick.Controls
import QtQuick.Layouts
import QtQuick

import Dockman.Theme
import "../components"

Dialog {
    id: root

    signal addRequested(string name, string address, int port)

    modal: true
    focus: true

    spacing: 0
    padding: 0
    width: 350
    height: 300

    background: Rectangle {
        color: Colors.background
        radius: Borders.radiusBase
        border.width: Borders.width1
        border.color: Colors.border
    }

    header: Rectangle {
        height: 56
        color: "transparent"

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Spacing.marginLg
            text: "Add Host"
            color: Colors.foreground
            font.pixelSize: Typography.sizeLg
            font.weight: Typography.weightBold
        }
    }

    footer: Rectangle {
        height: 64
        color: "transparent"

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: Spacing.marginMd
            anchors.rightMargin: Spacing.marginMd
            anchors.topMargin: Spacing.marginSm
            anchors.bottomMargin: Spacing.marginSm
            spacing: Spacing.space2

            StyledButton {
                id: createBtn
                Layout.fillWidth: true
                onClicked: {
                    root.accept()
                    root.addRequested(nameField.text, ipField.text, portField.text)
                }
                DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                text: "Add"
            }
            StyledButton {
                id: cancelBtn
                Layout.fillWidth: true
                onClicked: root.close()
                DialogButtonBox.buttonRole: DialogButtonBox.DestructiveRole
                text: "Cancel"
            }
        }
    }

    contentItem: ColumnLayout {
        spacing: Spacing.space3
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Spacing.marginMd
        anchors.rightMargin: Spacing.marginMd

        Text {
            text: "Host Name"
            color: Colors.foreground
            font.pixelSize: Typography.sizeBase
        }
        StyledTextField {
            id: nameField
            Layout.fillWidth: true

            placeholderText: "Host name"
        }

        Text {
            text: "Connection details"
            color: Colors.foreground
            font.pixelSize: Typography.sizeBase
        }
        RowLayout {
            Layout.fillWidth: true

            StyledTextField {
                id: ipField
                Layout.fillWidth: true

                placeholderText: "Ip address"
            }
            Text {
                text: ":"
                color: Colors.foreground
                font.pixelSize: Typography.sizeBase
            }
            StyledTextField {
                id: portField
                Layout.fillWidth: true

                placeholderText: "Port"
                validator: IntValidator {
                    bottom: 1
                    top: 65535
                }
                inputMethodHints: Qt.ImhDigitsOnly
            }
        }

        Item {Layout.fillHeight: true}
    }
}
