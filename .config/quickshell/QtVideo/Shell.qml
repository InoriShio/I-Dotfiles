import QtQuick
import Quickshell
import QtMultimedia
import Quickshell.Wayland

PanelWindow {
    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusiveZone: 1
    implicitHeight: Screen.height
    implicitWidth: Screen.width
    anchors {
        top: true
        bottom: true
        right: true
        left: true
    }

    Video {
        visible: true
        anchors.fill: parent
        source: "file:///home/inorishio/Videos/clips/IHateWomen.mp4"
        loops: MediaPlayer.Infinite
        autoPlay: true
        muted: true
        fillMode: VideoOutput.PreserveAspectCrop
    }
}
