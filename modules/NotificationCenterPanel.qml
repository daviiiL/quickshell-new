import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.common
import qs.components.notification
import qs.services

Scope {
    id: root

    property int animationDuration: 200
    property int panelWidth: 400
    property int panelHeight: 600

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel
            required property var modelData

            screen: modelData
            visible: GlobalStates.notificationCenterOpen

            anchors {
                right: true
                top: true
                bottom: true
            }

            margins {
                top: Theme.ui.topBarHeight + Theme.ui.padding.sm * 2
                right: Theme.ui.padding.sm
                bottom: Theme.ui.padding.sm
            }

            width: root.panelWidth
            color: "transparent"

            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            WlrLayershell.namespace: "quickshell:notificationcenter"

            Rectangle {
                id: contentRect
                anchors.fill: parent
                radius: Theme.ui.radius.md
                color: Colors.surface_light_translucent
                clip: true

                NotificationCenterView {
                    anchors.fill: parent
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: root.animationDuration
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: Theme.anim.curves.standard
                    }
                }
            }

            mask: Region {}

            // Close on Escape key
            Keys.onEscapePressed: {
                GlobalStates.notificationCenterOpen = false;
            }
        }
    }
}
