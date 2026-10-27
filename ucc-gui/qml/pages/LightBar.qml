
import QtQuick 2.15
Column { spacing: 16
    Text { text: "Light Bar"; color: "white"; font.pixelSize: 26; font.bold: true }
    Rectangle { width: 600; height: 80; radius: 24; color: "#24242e"; border.color: "#6c5cff"; border.width: 2
        Text { anchors.centerIn: parent; text: "Light Bar Preview - RGB effect"; color: "#aaa" }
    }
}
