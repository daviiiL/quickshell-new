import QtQuick
import QtQuick.Layouts

import qs.common

Rectangle {
    id: root
    color: "transparent"

    property bool showTitle: false
    property string title: ""
    property color contentBackground

    default property alias content: contentRect.data

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Rectangle {
            visible: root.showTitle
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            color: Colors.surface_container
            topRightRadius: Theme.ui.radius.md
            topLeftRadius: Theme.ui.radius.md

            Text {
                anchors.centerIn: parent
                text: root.title
                color: Qt.lighter(parent.color, 5)
                font.family: Theme.font.family.inter_thin
                font.pixelSize: Theme.font.size.md
            }
        }

        Rectangle {
            id: contentRect
            Layout.fillWidth: true
            Layout.fillHeight: true
            bottomLeftRadius: Theme.ui.radius.md
            bottomRightRadius: Theme.ui.radius.md
            topLeftRadius: root.showTitle ? 0 : Theme.ui.radius.md
            topRightRadius: root.showTitle ? 0 : Theme.ui.radius.md
            color: root.contentBackground
        }
    }
}
