import QtQuick
import Quickshell
import Quickshell.Wayland

QtObject {
    id: sessionLocker

    // store the lock object properly
    property WlSessionLock lock: WlSessionLock {
        id: theLock

        onLocked: {
            console.log("Session LOCKED")
        }

        onFinished: {
            console.log("Session UNLOCKED")
        }
    }

    function startLock() {
        lock.requestLock()
    }

    function unlock() {
        lock.unlockAndDestroy()
    }
}
