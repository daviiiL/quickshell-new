import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.common

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property var modelData

            screen: modelData
            color: "transparent"

            implicitHeight: Theme.ui.topBarHeight

            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.exclusiveZone: implicitHeight

            anchors {
                right: true
                left: true
                top: true
            }

            margins {
                left: Theme.ui.padding.sm
                right: Theme.ui.padding.sm
                top: Theme.ui.padding.sm
            }

            Rectangle {
                anchors.fill: parent
                radius: Theme.ui.radius.md

                color: Colors.surface_light_translucent
            }
        }
    }
}
