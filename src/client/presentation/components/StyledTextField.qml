import QtQuick
import QtQuick.Controls

import Dockman.Theme

TextField {
    id: field

    property string iconSource;
    property int iconSize: 22;
    property int iconSpacing: 10;

    property bool error: false

    background: Rectangle {
        id: rect
        color: Colors.background
        radius: Borders.radiusMd
        border.width: 1.2;
        border.color: Colors.border

        Behavior on border.color {
            ColorAnimation {
                duration: 150
            }
        }

        states: [
            State {
                name: "error"
                when: field.error
                PropertyChanges {rect.border.color: Colors.destructive }
            },
            State {
                name: "focused"
                when: field.activeFocus && !field.error
                PropertyChanges {rect.border.color: Colors.primary }
            }
        ]

        Image {
            source: field.iconSource;
            visible: field.iconSource !== ""
            width: field.iconSize
            height: field.iconSize
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Spacing.space2
        }
    }

    color: Colors.foreground
    font.pixelSize: Typography.sizeBase

    topPadding: Spacing.space2
    bottomPadding: Spacing.space2
    rightPadding: Spacing.space2
    leftPadding: field.iconSource === ""
                 ? Spacing.space2
                 : Spacing.space2 + iconSize + iconSpacing


    Keys.onEscapePressed: {
        field.focus = false
    }
}
