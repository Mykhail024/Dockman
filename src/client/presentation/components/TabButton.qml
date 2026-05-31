import QtQuick.Controls
import QtQuick.Effects
import QtQuick

import Dockman.Theme

Button {
    id: root

    contentItem: Row {
        spacing: Spacing.space2

        Image {
            id: icon
            width: root.icon.width > 0 ? root.icon.width : 16
            height: root.icon.height > 0 ? root.icon.height : 16
            source: root.icon.source
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
            visible: false
        }

        MultiEffect {
            width: icon.width
            height: icon.height
            source: icon
            colorization: 1.0
            colorizationColor: root.hovered ? Colors.foreground : Colors.mutedForeground
            visible: root.icon.source.toString() !== ""

            Behavior on colorizationColor {
                ColorAnimation { duration: Transitions.durationFast; easing: Easing.InQuad }
            }
        }

        Text {
            text: root.text
            font: root.font
            color: root.hovered ? Colors.foreground : Colors.mutedForeground

            Behavior on color {
                ColorAnimation { duration: Transitions.durationFast; easing: Easing.InQuad }
            }
        }
    }

    background: Rectangle {
        color: "white" 
        opacity: root.hovered ? 0.05 : 0.0
        radius: Borders.radiusSm

        Behavior on opacity {
            NumberAnimation { duration: Transitions.durationFast; easing: Easing.InQuad }
        }
    }
}
