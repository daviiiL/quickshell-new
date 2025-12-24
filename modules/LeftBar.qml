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

            margins {
                left: Theme.ui.padding.sm
                top: Theme.ui.padding.sm
                bottom: Theme.ui.padding.sm
            }

            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.exclusiveZone: implicitWidth

            anchors {
                left: true
                top: true
                bottom: true
            }

            Rectangle {
                anchors.fill: parent
                color: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.8)
                radius: Theme.ui.radius.md

                ColumnLayout {
                    anchors {
                        topMargin: 5
                        bottomMargin: 5
                    }
                    anchors.fill: parent
                    spacing: 5
                    ClockCard {
                        Layout.leftMargin: Theme.ui.padding.sm
                        Layout.rightMargin: Theme.ui.padding.sm
                        Layout.fillWidth: true
                    }
                    PowerDispCard {
                        Layout.leftMargin: Theme.ui.padding.sm
                        Layout.rightMargin: Theme.ui.padding.sm
                        Layout.fillWidth: true
                    }

                    SysIndicatorsCard {
                        Layout.leftMargin: Theme.ui.padding.sm
                        Layout.rightMargin: Theme.ui.padding.sm
                        Layout.fillWidth: true
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}
