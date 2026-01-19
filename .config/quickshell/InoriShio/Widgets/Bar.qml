// Bar.qml
import Quickshell
import qs.Widgets

Scope {
  // no more time object

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30

      Clock {
        anchors.centerIn: parent

        // no more time binding
      }
    }
  }
}
