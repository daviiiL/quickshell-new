pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root

    readonly property real brightness: _brightness
    readonly property bool available: Power.isLaptopBattery

    property real _brightness: 0
    property int _current: 0
    property int _max: 1
    property string _backlightPath: ""
    property string _brightnessPath: ""
    property string _maxBrightnessPath: ""

    Component.onCompleted: {
        if (available) {
            getBacklightDir.running = true;
        }
    }

    function increaseBrightness() {
        setBrightness(brightness + 5);
    }

    function decreaseBrightness() {
        setBrightness(brightness - 5);
    }

    function setBrightness(value) {
        if (!available)
            return;
        value = Math.max(1, Math.min(100, value));
        setProc.command = ["brightnessctl", "--class", "backlight", "s", value + "%", "--quiet"];
        setProc.running = true;
    }

    Process {
        id: getBacklightDir

        command: ["sh", "-c", "ls /sys/class/backlight | head -n 1"]

        stdout: StdioCollector {
            onStreamFinished: {
                const device = this.text.trim();
                if (device.length > 0) {
                    root._backlightPath = "/sys/class/backlight/" + device;
                    root._brightnessPath = root._backlightPath + "/brightness";
                    root._maxBrightnessPath = root._backlightPath + "/max_brightness";
                    // console.debug("Backlight device:", device);
                    // console.debug("Brightness path:", root._brightnessPath);
                    // console.debug("Max brightness path:", root._maxBrightnessPath);

                    checkPathsProc.running = true;
                }
            }
        }
    }

    Process {
        id: checkPathsProc

        command: ["sh", "-c", "test -f '" + root._brightnessPath + "' && test -f '" + root._maxBrightnessPath + "' && echo 'Paths exist' || echo 'Paths missing'"]

        stdout: StdioCollector {
            onStreamFinished: {}
        }
    }

    Process {
        id: setProc
    }

    FileView {
        id: maxBrightness

        path: Qt.resolvedUrl(_maxBrightnessPath)
        blockLoading: !available || _maxBrightnessPath === ""
        blockWrites: true

        onPathChanged: {
            // console.debug("Max brightness FileView path:", path)
        }

        onLoaded: {
            // console.debug("Max brightness loaded:", this.text());
            root._max = parseInt(this.text());
            root._updateBrightness();
        }
    }

    FileView {
        id: curBrightness

        path: Qt.resolvedUrl(_brightnessPath)
        blockLoading: !available || _brightnessPath === ""
        blockWrites: true
        watchChanges: true

        onPathChanged: {
            // console.debug("Current brightness FileView path:", path)
        }

        onLoaded: {
            // console.debug("Current brightness loaded:", this.text());
            root._current = parseInt(this.text());
            root._updateBrightness();
        }

        onFileChanged: {
            // console.debug("Brightness file changed");
            this.reload();
        }
    }

    function _updateBrightness() {
        if (_max > 0) {
            const newBrightness = (_current / _max) * 100;
            root._brightness = newBrightness;
        }
    }

    IpcHandler {
        target: "brightness"

        function increment() {
            root.increaseBrightness();
        }

        function decrement() {
            root.decreaseBrightness();
        }
    }

    GlobalShortcut {
        name: "brightnessIncrease"
        description: "Increase brightness"
        onPressed: root.increaseBrightness()
    }

    GlobalShortcut {
        name: "brightnessDecrease"
        description: "Decrease brightness"
        onPressed: root.decreaseBrightness()
    }
}
