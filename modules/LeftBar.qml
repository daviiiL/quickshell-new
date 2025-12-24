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
                left: Theme.ui.padding.small
                top: Theme.ui.padding.small
                bottom: Theme.ui.padding.small
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
                    anchors.fill: parent
                    spacing: Theme.ui.padding.small
                    ClockCard {
                        Layout.margins: Theme.ui.padding.small
                        Layout.fillWidth: true
                        // Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 115
                    }
                    PowerDispCard {
                        Layout.margins: Theme.ui.padding.small
                        Layout.fillWidth: true
                        Layout.preferredWidth: parent.width
                        // Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 140
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}
