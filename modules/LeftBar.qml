pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.common
import qs.components

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property var modelData

            screen: modelData
            color: "transparent"

            implicitWidth: Theme.ui.leftBarWidth

            // margins {
            //     left: Theme.ui.padding.sm
            //     top: Theme.ui.padding.sm
            //     bottom: Theme.ui.padding.sm
            // }
            //
            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.exclusiveZone: implicitWidth

            anchors {
                left: true
                top: true
                bottom: true
            }

            Rectangle {
                anchors.fill: parent
                color: Colors.surface_light_translucent
                radius: Theme.ui.radius.md

                anchors.margins: Theme.ui.padding.sm / 2

                ColumnLayout {
                    anchors {
                        topMargin: Theme.ui.padding.sm
                        bottomMargin: Theme.ui.padding.sm
                    }
                    anchors.fill: parent
                    spacing: 5
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                        Text {
                            text: "Sys"
                            color: Colors.secondary_container
                            font {
                                family: Theme.font.family.inter_bold
                            }
                        }
                        Text {
                            text: "v1"
                            color: Colors.secondary_container
                            font {}
                        }
                    }

                    ClockCard {
                        Layout.leftMargin: Theme.ui.padding.sm
                        Layout.rightMargin: Theme.ui.padding.sm
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                    }
                    BatteryCard {
                        Layout.leftMargin: Theme.ui.padding.sm
                        Layout.rightMargin: Theme.ui.padding.sm
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                    }

                    SystemButtonsCard {
                        Layout.leftMargin: Theme.ui.padding.sm
                        Layout.rightMargin: Theme.ui.padding.sm
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                    }
                    SystemTrayCard {
                        Layout.leftMargin: Theme.ui.padding.sm
                        Layout.rightMargin: Theme.ui.padding.sm
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }
        }
    }
}
