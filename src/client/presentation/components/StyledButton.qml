import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import ".."

import Dockman.Theme

Button {
    id: button

    property string iconSource: "";
    

    contentItem: RowLayout {
        anchors.fill: parent
        Item {
            visible: textInner.horizontalAlignment === Text.AlignHCenter
            Layout.fillWidth: true 
        }
        Image {
            Layout.leftMargin: 10
            source: button.iconSource
            visible: button.iconSource !== ""
        }
        Text {
            id: textInner
            text: button.text
            color: Colors.foreground
            font.pixelSize: Typography.sizeBase
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        Item { 
            Layout.fillWidth: true
        }
    }

    background: Rectangle {
        color: Colors.primary
        radius: Borders.radiusMd

        opacity: button.hovered ? 1.0 : 0.6

        implicitWidth: 40;
        implicitHeight: 40

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }

        Behavior on opacity { 
            NumberAnimation { duration: Transitions.durationFast; easing: Easing.InQuad }
        }
    }
}
