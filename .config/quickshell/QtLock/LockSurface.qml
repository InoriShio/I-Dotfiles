import QtQuick
import Quickshell
import Quickshell.Wayland

WlSessionLockSurface {
    id: lockSurface

    // match monitor resolution
    anchors.fill: screen

    Rectangle {
        anchors.fill: parent
        color: "#000000bb"

        Column {
            anchors.centerIn: parent
            spacing: 12

            Text {
                text: "Locked"
                color: "white"
                font.pointSize: 24
            }

            TextField {
                id: password
                width: 240
                placeholderText: "Password"
                echoMode: TextInput.Password

                Keys.onReturnPressed: {
                    if (password.text === "hello") {
                        locker.unlock()
                    } else {
                        password.text = ""
                    }
                }
            }
        }
    }
}
