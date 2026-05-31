import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick

import "./components"

import Dockman.Theme

ApplicationWindow {
    id: root

    width: 1200
    height: 700
    visible: true

    title: "Dockman"

    color: Colors.background

    RowLayout {
        anchors.fill: parent

        BorderBox {
            color: "transparent"
            antialiasing: true

            border: BorderProperties {
                right: Borders.width1
                color: Colors.border
            }

            Layout.preferredWidth: 250
            Layout.fillHeight: true

            BorderBox {
                id: logo
                color: "transparent"

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 50

                antialiasing: true
                border: BorderProperties {
                    bottom: Borders.width1
                    color: Colors.border
                }

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: Spacing.marginMd
                    spacing: 8

                    Rectangle {
                        color: Colors.primary
                        radius: Borders.radiusSm
                        width: Dimensions.iconXl
                        height: width

                        Image {
                            id: mapIcon
                            anchors.centerIn: parent

                            source: "qrc:/resources/icons/box.svg"
                            sourceSize.width: width // SVG render size
                            sourceSize.height: height

                            visible: false
                        }
                        MultiEffect {
                            source: mapIcon
                            anchors.fill: mapIcon
                            colorization: 1.0
                            colorizationColor: Colors.background
                        }
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        color: Colors.foreground
                        font.pixelSize: Typography.sizeLg
                        font.weight: Typography.weightSemibold

                        text: "Dockman"
                    }
                }
            }

            ColumnLayout {
                id: tabs

                anchors.top: logo.bottom
                anchors.left: logo.left
                anchors.right: logo.right

                anchors.leftMargin: Spacing.marginMd
                anchors.rightMargin: Spacing.marginSm
                anchors.topMargin: Spacing.marginMd
                anchors.bottomMargin: Spacing.marginMd

                TabButton {
                    Layout.fillWidth: true

                    text: "Overview"
                    icon.source: "qrc:/resources/icons/dashboard.svg"
                }
                TabButton {
                    Layout.fillWidth: true

                    text: "Containers"
                    icon.source: "qrc:/resources/icons/box.svg"
                }
                TabButton {
                    Layout.fillWidth: true

                    text: "Images"
                    icon.source: "qrc:/resources/icons/hard-drive.svg"
                }
                TabButton {
                    Layout.fillWidth: true

                    text: "Networks"
                    icon.source: "qrc:/resources/icons/network.svg"
                }
                TabButton {
                    Layout.fillWidth: true

                    text: "Volumes"
                    icon.source: "qrc:/resources/icons/hard-drive.svg"
                }
                TabButton {
                    Layout.fillWidth: true

                    text: "Logs"
                    icon.source: "qrc:/resources/icons/terminal.svg"
                }
            }

            ColumnLayout {
                id: hosts
                anchors.top: tabs.bottom
                anchors.left: tabs.left
                anchors.right: tabs.right
                anchors.topMargin: Spacing.marginXl

                RowLayout {
                    Text { 
                        text: "HOSTS"
                        color: Colors.foreground
                        font.pixelSize: Typography.sizeBase
                        font.weight: Typography.weightNormal
                    }
                    Item { Layout.fillWidth: true }
                    Button {
                        id: addHostButton

                        Layout.preferredWidth: 26
                        Layout.preferredHeight: 26
                        background: Rectangle {
                            color: addHostButton.hovered ? Colors.primary : "transparent"
                            radius: Borders.radiusSm

                            Behavior on color {
                                ColorAnimation { duration: Transitions.durationFast; easing: Easing.InQuad }
                            }
                        }
                        contentItem: Text {
                            text: "+"
                            font.pixelSize: Typography.sizeLg
                            font.weight: Typography.weightSemibold
                            color: addHostButton.hovered ? Colors.background : "white" 
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter

                            Behavior on color {
                                ColorAnimation { duration: Transitions.durationFast; easing: Easing.InQuad }
                            }
                        }
                    }

                }

                ListView {
                    id: hostListView

                    Layout.fillWidth: true
                    Layout.preferredHeight: Math.min(hostListModel.rowCount(), 4) * 45

                    delegate: HostListItem {}

                    model: hostListModel
                }
            }

            BorderBox {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                height: 60
                
                anchors.margins: 0

                border: BorderProperties {
                    top: Borders.width1
                    right: Borders.width1
                    color: Colors.border
                }

                color: Colors.background

                TabButton {
                    id: settingsBtn

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: Spacing.marginMd
                    anchors.bottomMargin: Spacing.marginMd
                    anchors.leftMargin: Spacing.marginMd
                    anchors.rightMargin: Spacing.marginSm
                    height: 32
                    
                    text: "Settings"
                    icon.source: "qrc:/resources/icons/settings.svg"
                }
            }
        }

    }
}
