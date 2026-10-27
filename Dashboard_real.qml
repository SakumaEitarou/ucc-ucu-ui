
import QtQuick 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
    spacing: 20
    Text { text: "Dashboard - Live from uccd"; color: "white"; font.pixelSize: 28; font.bold: true }

    GridLayout {
        columns: 4; columnSpacing: 16
        Repeater {
            model: [
                {title: "CPU", value: Telemetry.cpuTemp + "°", usage: "Ryzen 9 9955HX3D"},
                {title: "GPU", value: Telemetry.gpuTemp + "°", usage: "RTX 5090 Laptop"},
                {title: "FAN", value: "2100", usage: "RPM"},
                {title: "LIQUID", value: Telemetry.liquidTemp + "°", usage: "OASIS MK2"}
            ]
            delegate: Rectangle {
                width: 220; height: 120; radius: 16; color: "#24242e"
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 16
                    Text { text: modelData.title; color: "#7a7a90"; font.pixelSize: 11; font.bold: true }
                    Text { text: modelData.value; color: "white"; font.pixelSize: 28; font.bold: true }
                    Text { text: modelData.usage; color: "#8a8aa0"; font.pixelSize: 12 }
                }
            }
        }
    }
}
