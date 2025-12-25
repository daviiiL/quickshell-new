import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.common
import qs.components
import qs.services

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

            Rectangle {
                anchors.fill: parent
                radius: Theme.ui.radius.md

                anchors.margins: Theme.ui.padding.sm / 2

                color: Colors.surface_light_translucent

                RowLayout {
                    anchors.fill: parent
                    spacing: Theme.ui.padding.md

                    Workspaces {
                        Layout.fillHeight: true
                        Layout.leftMargin: Theme.ui.padding.sm
                    }

                    Item {
                        id: osdContainer
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        TopProgressBar {
                            id: progressbar
                            property bool showing: false
                            visible: opacity > 0
                            opacity: showing ? 1 : 0
                            scale: showing ? 1 : 0.95

                            Behavior on opacity {
                                NumberAnimation {
                                    duration: Theme.anim.durations.sm
                                    easing.type: Easing.Bezier
                                    easing.bezierCurve: Theme.anim.curves.emphasized
                                }
                            }

                            Behavior on scale {
                                NumberAnimation {
                                    duration: Theme.anim.durations.sm
                                    easing.type: Easing.Bezier
                                    easing.bezierCurve: Theme.anim.curves.emphasized
                                }
                            }
                        }

                        Timer {
                            id: hideTopProgressBar
                            interval: 1000
                            running: false

                            onTriggered: progressbar.showing = false
                        }

                        Connections {
                            target: Audio.defaultSinkAudio

                            function onVolumeChanged() {
                                progressbar.value = Audio.volume;
                                progressbar.max = 1;
                                progressbar.text = "Volume";
                                progressbar.showing = true;
                                hideTopProgressBar.restart();
                            }

                            function onMutedChanged() {
                                progressbar.value = Audio.volume;
                                progressbar.max = 1;
                                progressbar.text = "Volume";
                                progressbar.showing = true;
                                hideTopProgressBar.restart();
                            }
                        }

                        Connections {
                            target: Brightness

                            function onBrightnessChanged() {
                                progressbar.value = Brightness.brightness;
                                progressbar.max = 100;
                                progressbar.text = "Brightness";
                                progressbar.showing = true;
                                hideTopProgressBar.restart();
                            }
                        }
                    }
                }
            }
        }
    }
}
