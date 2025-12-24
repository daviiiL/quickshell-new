import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.common
import qs.services

RectWidgetCard {
    showTitle: true
    title: "Battery"

    ColumnLayout {
        spacing: 5
        anchors.fill: parent

        Text {
            text: `BAT ${Power.percentage}%`
            font.family: Theme.font.family.inter_regular
            font.pixelSize: Theme.font.size.xs
            color: Colors.primary
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.topMargin: 5
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
        }

        BatteryProgressBar {
            id: progressBar
            Layout.fillWidth: true
            Layout.preferredHeight: 25
        }

        Text {
            text: `EST ${Power.timeToGoal} ${Power.isCharging ? "till full" : "left"}`
            font.family: Theme.font.family.inter_regular
            font.pixelSize: Theme.font.size.xs
            color: Colors.primary
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 5
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }
    }
}
