import QtQuick

Item {
    id: root

    property alias color: mainRect.color

    property BorderProperties border

    Rectangle {
        id: mainRect
        anchors.fill: parent
    }

    Rectangle {
        visible: root.border.top > 0
        height: root.border.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        color: root.border.color

        antialiasing: root.antialiasing
    }

    Rectangle {
        visible: root.border.right > 0
        width: root.border.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        color: root.border.color


        antialiasing: root.antialiasing
    }

    Rectangle {
        visible: root.border.bottom > 0
        height: root.border.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: root.border.color

        antialiasing: root.antialiasing
    }

    Rectangle {
        visible: root.border.left > 0
        width: root.border.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        color: root.border.color

        antialiasing: root.antialiasing
    }
}
