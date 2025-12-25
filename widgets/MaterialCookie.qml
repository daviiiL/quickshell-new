import QtQuick
import QtQuick.Shapes
import qs.common

Item {
    id: root

    property color color: Colors.primary_container
    property int sides: 6
    property real irregularity: 0.15
    property real amplitude: 1.0
    property bool animate: true

    implicitWidth: 48
    implicitHeight: 48

    Shape {
        id: shape
        anchors.fill: parent

        ShapePath {
            id: shapePath

            fillColor: root.color
            strokeColor: "transparent"

            startX: root.width / 2
            startY: root.height / 2

            property real animPhase: 0

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root.width / 2 * (1 - root.irregularity + root.irregularity * (1 + Math.sin(shapePath.animPhase)))
                radiusY: root.height / 2 * (1 - root.irregularity + root.irregularity * (1 + Math.cos(shapePath.animPhase)))
                startAngle: 0
                sweepAngle: 360
            }

            NumberAnimation on animPhase {
                running: root.animate
                from: 0
                to: Math.PI * 2
                duration: Theme.anim.durations.xl * 3
                loops: Animation.Infinite
                easing.type: Easing.InOutSine
            }
        }

        layer.enabled: true
        layer.samples: 4
    }

    Behavior on color {
        ColorAnimation {
            duration: Theme.anim.durations.sm
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Theme.anim.curves.standard
        }
    }
}
