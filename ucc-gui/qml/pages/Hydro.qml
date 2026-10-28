import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent

    property color card: "#1a1a24"
    property color cardBorder: "#252530"
    property color textMain: "#e8e8f0"
    property color textSub: "#7a7a90"
    property color accent: "#6c5cff"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16

        RowLayout {
            Layout.fillWidth: true
            Text { text: "OASIS Cooling"; color: textMain; font.pixelSize: 26; font.bold: true }
            Item { Layout.fillWidth: true }
            Rectangle { width: 120; height: 32; radius: 16; color: Telemetry.oasisConnected ? "#1e3a2e" : "#3a1e1e"
                RowLayout { anchors.centerIn: parent; spacing: 6
                    Rectangle { width: 8; height: 8; radius: 4; color: Telemetry.oasisConnected ? "#3dd598" : "#ff5555" }
                    Text { text: Telemetry.oasisConnected ? "Connected Mk2-V4" : "Disconnected"; color: Telemetry.oasisConnected ? "#3dd598" : "#ff8888"; font.pixelSize: 12; font.bold: true }
                }
            }
        }

        GridLayout {
            columns: 2
            columnSpacing: 16
            rowSpacing: 16
            Layout.fillWidth: true
            Layout.fillHeight: true

            // Main Hydro visual - big
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true; Layout.columnSpan: 2; Layout.preferredHeight: 300; color: card; radius: 24; border.color: accent; border.width: 1.5
                RowLayout {
                    anchors.fill: parent; anchors.margins: 24; spacing: 24

                    // Left - large pump visualization
                    Item { width: 220; height: 220
                        Canvas {
                            id: pumpCanvas
                            anchors.fill: parent
                            property real level: Telemetry.waterPump / 100
                            onLevelChanged: requestPaint()
                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.reset()
                                // outer ring
                                ctx.strokeStyle = "#2a2a3a"; ctx.lineWidth = 12
                                ctx.beginPath(); ctx.arc(110,110,90,0,Math.PI*2); ctx.stroke()
                                // progress
                                ctx.strokeStyle = accent; ctx.lineCap = "round"
                                ctx.beginPath(); ctx.arc(110,110,90,-Math.PI/2, -Math.PI/2 + Math.PI*2*level); ctx.stroke()
                                // liquid fill
                                ctx.fillStyle = "#6c5cff44"
                                ctx.beginPath()
                                var h = 180 * level
                                ctx.rect(20, 180-h+20, 180, h)
                                ctx.fill()
                            }
                        }
                        ColumnLayout { anchors.centerIn: parent
                            Text { Layout.alignment: Qt.AlignHCenter; text: Telemetry.waterPump + "%"; color: textMain; font.pixelSize: 44; font.bold: true }
                            Text { Layout.alignment: Qt.AlignHCenter; text: "PUMP SPEED"; color: textSub; font.pixelSize: 12; font.letterSpacing: 1 }
                            Text { Layout.alignment: Qt.AlignHCenter; text: Telemetry.waterFan + " RPM"; color: accent; font.pixelSize: 13; font.bold: true }
                        }
                    }

                    // Right - controls
                    ColumnLayout { Layout.fillWidth: true; spacing: 20
                        ColumnLayout { spacing: 8; Layout.fillWidth: true
                            RowLayout { Text { text: "Pump Speed"; color: textMain; font.pixelSize: 14; font.bold: true } Item { Layout.fillWidth: true } Text { text: Telemetry.waterPump + "%"; color: textMain; font.pixelSize: 14 } }
                            Rectangle { Layout.fillWidth: true; height: 8; radius: 4; color: "#252530"
                                Rectangle { width: parent.width * (Telemetry.waterPump/100); height: parent.height; radius: 4; color: accent }
                                Rectangle { x: parent.width * (Telemetry.waterPump/100) - 10; y: -6; width: 20; height: 20; radius: 10; color: "white"; border.color: accent; border.width: 2 }
                            }
                            Text { text: "Adjust pump for coolant flow • OASIS Mk2-V4 external radiator"; color: textSub; font.pixelSize: 11 }
                        }
                        ColumnLayout { spacing: 8; Layout.fillWidth: true
                            RowLayout { Text { text: "Radiator Fans"; color: textMain; font.pixelSize: 14; font.bold: true } Item { Layout.fillWidth: true } Text { text: Math.round(Telemetry.waterFan/1.5) + "% • " + Telemetry.waterFan + " RPM"; color: textMain; font.pixelSize: 14 } }
                            Rectangle { Layout.fillWidth: true; height: 8; radius: 4; color: "#252530"
                                Rectangle { width: parent.width * 0.64; height: parent.height; radius: 4; color: "#4ecdc4" }
                            }
                        }
                        GridLayout { columns: 4; columnSpacing: 12; Layout.fillWidth: true
                            Repeater { model: [
                                {label:"COOLANT IN", val: (Telemetry.cpuTemp - 24) + "°C"},
                                {label:"COOLANT OUT", val: (Telemetry.gpuTemp - 10) + "°C"},
                                {label:"FLOW RATE", val:"2.1 L/m"},
                                {label:"NOISE", val:"24 dB"}
                            ]
                                Rectangle { Layout.fillWidth: true; height: 64; radius: 12; color: "#15151d"
                                    ColumnLayout { anchors.fill: parent; anchors.margins: 12; spacing: 4
                                        Text { text: modelData.label; color: textSub; font.pixelSize: 9; font.letterSpacing: 1 }
                                        Text { text: modelData.val; color: textMain; font.pixelSize: 16; font.bold: true }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Coolant temps
            Rectangle { Layout.fillWidth: true; height: 100; color: card; radius: 16; border.color: cardBorder; border.width: 1
                RowLayout { anchors.fill: parent; anchors.margins: 16; spacing: 16
                    Text { text: "🌡"; font.pixelSize: 24 }
                    ColumnLayout { Text { text: "Coolant Temperature"; color: textMain; font.bold: true } Text { text: "Optimal range 32-45°C for OASIS Mk2-V4"; color: textSub; font.pixelSize: 11 } }
                    Item { Layout.fillWidth: true }
                    Text { text: "38.2°C"; color: "#3dd598"; font.pixelSize: 20; font.bold: true }
                }
            }
            Rectangle { Layout.fillWidth: true; height: 100; color: card; radius: 16; border.color: cardBorder; border.width: 1
                RowLayout { anchors.fill: parent; anchors.margins: 16; spacing: 16
                    Text { text: "💨"; font.pixelSize: 24 }
                    ColumnLayout { Text { text: "External Radiator"; color: textMain; font.bold: true } Text { text: "XMG OASIS + 140mm fans"; color: textSub; font.pixelSize: 11 } }
                    Item { Layout.fillWidth: true }
                    Text { text: "LIQ " + Telemetry.waterFan + " RPM"; color: accent; font.pixelSize: 16; font.bold: true }
                }
            }
        }
    }
}
