import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick

PanelWindow {
    id: root

    SessionLocker {
        id: locker
    }

    // create a lock surface per monitor
    Component.onCompleted: {
        locker.startLock()
        for (let screen of Screens) {
            lockSurfaceComponent.createObject(root, { "screen": screen })
        }
    }

    Component {
        id: lockSurfaceComponent
        LockSurface { }
    }
}
