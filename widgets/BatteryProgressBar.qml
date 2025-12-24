pragma ComponentBehavior: Bound

import QtQuick
import Qt5Compat.GraphicalEffects
import qs.common

Item {
    id: root
    width: parent.width
    property int total: 100
    property real value: 77.6

    Rectangle {
        id: background
        anchors.fill: parent
        color: Colors.surface_container
        anchors.leftMargin: Theme.ui.padding.small
        anchors.rightMargin: Theme.ui.padding.small
        radius: Theme.ui.radius.md
        antialiasing: true
        smooth: true

        border {
            width: Theme.ui.borderWidth
            color: Colors.primary
        }

        Item {
            id: progressContainer
            anchors.fill: parent
            anchors.margins: Theme.ui.borderWidth + 1

            Item {
                id: progressLayer
                anchors.fill: parent
                layer.enabled: true
                visible: false

                Rectangle {
                    id: progress
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }
                    width: parent.width * (root.value / 100)
                    color: "red"
                }
            }

            Rectangle {
                id: mask
                anchors.fill: parent
                radius: Theme.ui.radius.md
                antialiasing: true
                visible: false
            }

            OpacityMask {
                anchors.fill: parent
                source: progressLayer
                maskSource: mask
                smooth: true
            }
        }
        //
        // Canvas {
        //     id: canvas
        //     anchors.fill: parent
        //
        //     property color markerColor: Colors.primary
        //     property real dpr: Screen.devicePixelRatio
        //
        //     width: parent.width
        //     height: parent.height
        //     canvasSize.width: width * dpr
        //     canvasSize.height: height * dpr
        //
        //     antialiasing: true
        //     smooth: true
        //
        //     onPaint: {
        //         var ctx = getContext("2d");
        //         ctx.save();
        //
        //         // Scale for high DPI
        //         ctx.scale(dpr, dpr);
        //         ctx.clearRect(0, 0, width, height);
        //
        //         // Set line style
        //         ctx.strokeStyle = markerColor;
        //         ctx.globalAlpha = 0.5;
        //         ctx.lineWidth = 1;
        //
        //         var markers = [0.25, 0.50, 0.75];
        //         for (var i = 0; i < markers.length; i++) {
        //             var x = width * markers[i];
        //             ctx.beginPath();
        //             ctx.moveTo(x, 0);
        //             ctx.lineTo(x, height);
        //             ctx.stroke();
        //         }
        //
        //         ctx.restore();
        //     }
        //
        //     // Repaint when size or DPI changes
        //     onWidthChanged: requestPaint()
        //     onHeightChanged: requestPaint()
        //     onDprChanged: requestPaint()
        // }
    }
}
