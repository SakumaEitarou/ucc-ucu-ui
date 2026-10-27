
import QtQuick 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
    spacing: 20
    Text { text: "Dashboard"; color: "white"; font.pixelSize: 28; font.bold: true }
    Text { text: "XMG Neo 16 A25 - Ryzen 9 9955HX3D / RTX 5090 / OASIS MK2"; color: "#8a8aa0"; font.pixelSize: 13 }

    GridLayout {
        columns: 4
        columnSpacing: 16
        rowSpacing: 16
        Layout.fillWidth: true

        Repeater {
            model: [
                {title: "CPU", value: "68°", usage: "42%", sub: "4.8 GHz"},
                {title: "GPU", value: "54°", usage: "28%", sub: "RTX 5090"},
                {title: "FAN", value: "2100", usage: "RPM", sub: "CPU+GPU"},
                {title: "LIQUID", value: "38°", usage: "Pump", sub: "2400 RPM"}
            ]
            delegate: Rectangle {
                width: 220; height: 120; radius: 16; color: "#24242e"
                border.color: "#2f2f40"; border.width: 1
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 16
                    Text { text: modelData.title; color: "#7a7a90"; font.pixelSize: 11; font.bold: true }
                    RowLayout {
                        Text { text: modelData.value; color: "white"; font.pixelSize: 28; font.bold: true }
                        Text { text: modelData.usage; color: "#6c5cff"; font.pixelSize: 14; Layout.alignment: Qt.AlignBottom }
                    }
                    Text { text: modelData.sub; color: "#8a8aa0"; font.pixelSize: 12 }
                }
            }
        }
    }

    // Quick controls row like UCU
    RowLayout {
        spacing: 16
        Layout.fillWidth: true
        Rectangle { Layout.fillWidth: true; height: 180; radius: 16; color: "#24242e"; 
            Column { anchors.centerIn: parent; spacing: 8
                Text { text: "Performance Preset"; color: "white"; font.bold: true; anchors.horizontalCenter: parent.horizontalCenter }
                Row { spacing: 8; anchors.horizontalCenter: parent.horizontalCenter
                    Repeater { model: ["Office","Gaming","Turbo"]
                        delegate: Rectangle { width: 80; height: 36; radius: 18; color: index==1 ? "#6c5cff" : "#2e2e3d"; Text { anchors.centerIn: parent; text: modelData; color: "white"; font.pixelSize: 12 } }
                    }
                }
            }
        }
        Rectangle { Layout.fillWidth: true; height: 180; radius: 16; color: "#24242e";
            Column { anchors.centerIn: parent; Text { text: "Hydro UI - Quick Toggle"; color: "white"; font.bold: true } Text { text: "Pump: Balanced | Fan: Auto"; color: "#888" } }
        }
    }
}
