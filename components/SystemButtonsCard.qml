import QtQuick
import QtQuick.Layouts
import Quickshell.Bluetooth

import qs.widgets
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

            checked: Bluetooth.defaultAdapter?.enabled ?? false
            buttonIcon: checked ? "bluetooth" : "bluetooth_disabled"
            buttonText: "BT"
            onClicked: () => {
                if (Bluetooth.defaultAdapter) {
                    Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
                }
            }
        }
        SysIndicatorButton {
            Layout.alignment: Qt.AlignHCenter

            buttonIcon: Network.materialSymbol
            buttonText: {
                if (Network.ethernet)
                    return "Ethernet";
                return "WiFi";
            }
            checked: {
                if (Network.wifiEnabled || Network.wifiScanning || Network.wifiConnecting || Network.ethernet) {
                    return true;
                } else {
                    return false;
                }
            }

            onClicked: () => Network.toggleWifi()
        }
        SysIndicatorButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 10

            buttonIcon: Power.powerProfileIcon
            buttonText: Power.powerProfileText

            onClicked: () => {
                if (checked) {
                    Power.setPowerProfile("PowerSaver");
                } else {
                    Power.setPowerProfile("Performance");
                }
              }
        }
  } 
}
