import QtQuick
import QtQuick.Layouts
import qs.common

Rectangle {
    id: root
    property bool checked: false
    property string buttonIcon: "wifi"
    property string buttonText: "WiFi"

    function makeTranslucent(color) {
        return Qt.rgba(color.r, color.g, color.b, 0.4);
    }

    width: 45
    height: 45

    radius: Theme.ui.radius.md
    color: checked ? root.makeTranslucent(Colors.primary_container) : root.makeTranslucent(Colors.secondary_container)

    border {
        color: checked ? Colors.primary_container : Colors.secondary_container
    }
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        MaterialSymbol {
            Layout.alignment: Qt.AlignHCenter
            icon: root.buttonIcon
            iconSize: Theme.font.size.sm
            fontColor: root.checked ? Colors.on_primary_container : Colors.on_secondary_container
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            font {
                family: Theme.font.family.inter_thin
                pixelSize: Theme.font.size.xxs
            }
            color: root.checked ? Colors.on_primary_container : Colors.on_secondary_container
            text: root.buttonText
        }
    }
    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent

        onClicked: () => {
            root.checked = !root.checked;
        }
    }
}
