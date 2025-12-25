import QtQuick
import QtQuick.Controls
import qs.common

ListView {
    id: root

    property int dragIndex: -1
    property real dragDistance: 0

    function resetDrag() {
        dragIndex = -1;
        dragDistance = 0;
    }

    spacing: 5
    clip: true

    // Smooth scrolling
    maximumFlickVelocity: 4000
    flickDeceleration: 1500

    // Add transition
    add: Transition {
        id: addTransition

        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: Theme.anim.durations.sm
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Theme.anim.curves.standard
        }

        NumberAnimation {
            property: "scale"
            from: 0.9
            to: 1
            duration: Theme.anim.durations.sm
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Theme.anim.curves.emphasized
        }
    }

    // Remove transition
    remove: Transition {
        id: removeTransition

        SequentialAnimation {
            PropertyAction {
                property: "ListView.delayRemove"
                value: true
            }

            ParallelAnimation {
                NumberAnimation {
                    property: "opacity"
                    to: 0
                    duration: Theme.anim.durations.xs
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.anim.curves.standard
                }

                NumberAnimation {
                    property: "scale"
                    to: 0.9
                    duration: Theme.anim.durations.xs
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.anim.curves.emphasized
                }

                NumberAnimation {
                    property: "height"
                    to: 0
                    duration: Theme.anim.durations.xs
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.anim.curves.emphasized
                }
            }

            PropertyAction {
                property: "ListView.delayRemove"
                value: false
            }
        }
    }

    // Displaced (when items are moved around due to add/remove)
    displaced: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: Theme.anim.durations.sm
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Theme.anim.curves.emphasized
        }
    }

    // Move transition
    move: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: Theme.anim.durations.sm
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Theme.anim.curves.emphasized
        }
    }

    // Scroll bar
    ScrollBar.vertical: ScrollBar {
        id: scrollBar

        policy: ScrollBar.AsNeeded

        contentItem: Rectangle {
            implicitWidth: 6
            implicitHeight: 100
            radius: 3
            color: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, 0.3)

            Behavior on opacity {
                NumberAnimation {
                    duration: Theme.anim.durations.xs
                }
            }
        }

        background: Rectangle {
            color: "transparent"
        }
    }
}
