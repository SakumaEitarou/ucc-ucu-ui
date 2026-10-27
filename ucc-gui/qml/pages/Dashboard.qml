import QtQuick 2.15
import QtQuick.Layouts 1.15
ColumnLayout {
    spacing: 20
    Text { text: "Dashboard - Live from uccd"; color: "white"; font.pixelSize: 28; font.bold: true }
    Text { text: "XMG Neo 16 A25 + XMG OASIS (Mk2-V4)"; color: "#8a8aa0"; font.pixelSize: 13 }
    GridLayout {
        columns: 4; columnSpacing: 16; rowSpacing: 16; Layout.fillWidth: true
        Rectangle { width: 220; height: 120; radius: 16; color: "#24242e"; border.color: "#2f2f40"; border.width: 1
            ColumnLayout { anchors.fill: parent; anchors.margins: 16
                Text { text: "CPU"; color: "#7a7a90"; font.pixelSize: 11; font.bold: true }
                Text { text: Telemetry.cpuTemp + "°"; color: "white"; font.pixelSize: 28; font.bold: true }
                Text { text: "9955HX3D"; color: "#8a8aa0"; font.pixelSize: 12 }
            }
        }
        Rectangle { width: 220; height: 120; radius: 16; color: "#24242e"; border.color: "#2f2f40"; border.width: 1
            ColumnLayout { anchors.fill: parent; anchors.margins: 16
                Text { text: "GPU"; color: "#7a7a90"; font.pixelSize: 11; font.bold: true }
                Text { text: Telemetry.gpuTemp + "°"; color: "white"; font.pixelSize: 28; font.bold: true }
                Text { text: "RTX 5090 Laptop"; color: "#8a8aa0"; font.pixelSize: 12 }
            }
        }
        Rectangle { width: 220; height: 120; radius: 16; color: "#24242e"; border.color: "#2f2f40"; border.width: 1
            ColumnLayout { anchors.fill: parent; anchors.margins: 16
                Text { text: "FAN"; color: "#7a7a90"; font.pixelSize: 11; font.bold: true }
                Text { text: Telemetry.cpuFan + ""; color: "white"; font.pixelSize: 28; font.bold: true }
                Text { text: "RPM"; color: "#8a8aa0"; font.pixelSize: 12 }
            }
        }
        Rectangle { width: 220; height: 120; radius: 16; color: "#24242e"; border.color: "#6c5cff"; border.width: 1
            ColumnLayout { anchors.fill: parent; anchors.margins: 16
                Text { text: "LIQUID"; color: "#7a7a90"; font.pixelSize: 11; font.bold: true }
                Text { text: "OASIS"; color: "white"; font.pixelSize: 20; font.bold: true }
                Text { text: "Mk2-V4 Connected"; color: "#6c5cff"; font.pixelSize: 12; font.bold: true }
            }
        }
    }
}
