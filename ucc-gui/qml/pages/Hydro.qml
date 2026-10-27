
import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
ColumnLayout { spacing: 20
    Text { text: "Hydro UI - OASIS Liquid Cooler"; color: "white"; font.pixelSize: 26; font.bold: true }
    RowLayout { spacing: 16
        Rectangle { width: 320; height: 280; radius: 16; color: "#24242e"; ColumnLayout { anchors.fill: parent; anchors.margins: 16; spacing: 12
            Text { text: "Pump Speed"; color: "white"; font.bold: true }
            Slider { from: 0; to: 100; value: 60; Layout.fillWidth: true }
            Text { text: "Fan Speed"; color: "white"; font.bold: true }
            Slider { from: 0; to: 100; value: 40; Layout.fillWidth: true }
            Text { text: "RGB"; color: "white"; font.bold: true }
            Row { spacing: 8; Repeater { model: ["#6c5cff","#ff4d6d","#00e5a0","#ffcc00"]; delegate: Rectangle { width: 32; height: 32; radius: 16; color: modelData } } }
        }}
        Rectangle { width: 320; height: 280; radius: 16; color: "#24242e"; 
            Text { anchors.centerIn: parent; text: "💧 Pump 2400 RPM\nLiquid 38°C\n\nПодключи к:\nlibucc-dbus hydro control"; color: "#aaa"; horizontalAlignment: Text.AlignHCenter }
        }
    }
}
