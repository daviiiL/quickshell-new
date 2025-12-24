import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.common
import qs.services

RectWidgetCard {
    showTitle: true
    title: "System"

    ColumnLayout {
        spacing: 5
        width: parent.width
        SysIndicatorButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 10
        }
        SysIndicatorButton {
            Layout.alignment: Qt.AlignHCenter
        }
        SysIndicatorButton {
            Layout.alignment: Qt.AlignHCenter
        }
        SysIndicatorButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 10

            buttonIcon: Power.powerProfileIcon
            buttonText: Power.powerProfileText

            checked: Power.currentProfile === "Performance"
            onClicked: !checked ? Power.setPowerProfile("PowerSaver") : Power.setPowerProfile("Performance")
        }
    }
}
