
import QtQuick 2.15
import QtQuick.Layouts 1.15
ColumnLayout { spacing: 16
    Text { text: "Keyboard - Per-Key RGB"; color: "white"; font.pixelSize: 26; font.bold: true }
    Rectangle { width: 700; height: 260; radius: 16; color: "#24242e"
        Grid { anchors.centerIn: parent; columns: 14; spacing: 6
            Repeater { model: 70; delegate: Rectangle { width: 32; height: 32; radius: 6; color: index%3==0?"#6c5cff":"#2e2e3d"; border.color: "#3a3a50" } }
        }
    }
    Text { text: "BetterRGB streamer: UccBackend.setKeyboardColor('#6c5cff')"; color: "#666" }
}
