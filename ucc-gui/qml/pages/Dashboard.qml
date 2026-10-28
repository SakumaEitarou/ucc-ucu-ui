import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent
    property color card: "#1a1a24"
    property color cardBorder: "#2a2a40"
    property color textMain: "#ffffff"
    property color textSub: "#9a9ab0"
    property color accent: "#6c5cff"

    function pumpPct(v) {
        if(v<=0) return 66
        if(v===1) return 33
        if(v===2) return 66
        if(v===3) return 100
        return v<=100?v:66
    }
    function pumpLabel(v) {
        if(v===0) return "Med"
        if(v===1) return "Low"
        if(v===2) return "Med"
        if(v===3) return "High"
        return v+"%"
    }

    Flickable {
        anchors.fill: parent
        anchors.margins: 14
        contentHeight: mainCol.implicitHeight + 20
        clip: false

        ColumnLayout {
            id: mainCol
            width: parent.width
            spacing: 12

            RowLayout { Layout.fillWidth: true
                ColumnLayout {
                    Text { text: "Dashboard"; color: textMain; font.pixelSize: root.width<800?20:24; font.bold: true }
                    Text { text: "Telemetry • XMG NEO A25 • CachyOS • Ryzen 9 9955HX3D • " + Telemetry.cpuTemp + "°C • " + Telemetry.gpuTemp + "°C"; color: textSub; font.pixelSize: 10 }
                }
                Item { Layout.fillWidth: true }
            }

            // Responsive 4 cards: 4 cols on wide, 2 cols on narrow
            GridLayout {
                id: grid4
                Layout.fillWidth: true
                columns: root.width < 900 ? 2 : 4
                columnSpacing: 10
                rowSpacing: 10

                Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 130; color: card; radius: 14; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 12; spacing: 6
                        RowLayout { Text { text: "CPU"; color: textSub; font.pixelSize: 9; font.bold: true } Item { Layout.fillWidth: true } Rectangle { width: 48; height: 16; radius: 8; color: "#1e3a2e"; Text { anchors.centerIn: parent; text: Telemetry.cpuTemp + "°C"; color: "#3dd598"; font.pixelSize: 9; font.bold: true } } }
                        RowLayout { spacing: 8
                            Canvas { width: 56; height: 56
                                property int pct: Telemetry.cpuFanPct
                                onPctChanged: requestPaint()
                                onPaint: { var ctx=getContext("2d"); ctx.reset(); ctx.strokeStyle="#2a2a3a"; ctx.lineWidth=4; ctx.beginPath(); ctx.arc(28,28,22,0,Math.PI*2); ctx.stroke(); ctx.strokeStyle="#7c6cff"; ctx.beginPath(); ctx.arc(28,28,22,-Math.PI/2,-Math.PI/2+Math.PI*2*pct/100); ctx.stroke() }
                            }
                            ColumnLayout { spacing: 1
                                Text { text: Telemetry.cpuFanPct + "%"; color: textMain; font.pixelSize: 18; font.bold: true }
                                Text { text: "USAGE"; color: textSub; font.pixelSize: 7 }
                                Text { text: (Telemetry.cpuFreq/1000).toFixed(2) + " GHz"; color: textMain; font.pixelSize: 10 }
                                Text { text: Telemetry.cpuPower.toFixed(0) + " W / 170 W TDP"; color: textSub; font.pixelSize: 8 }
                            }
                        }
                    }
                }
                Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 130; color: card; radius: 14; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 12; spacing: 6
                        RowLayout { Text { text: "GPU"; color: textSub; font.pixelSize: 9; font.bold: true } Item { Layout.fillWidth: true } Rectangle { width: 48; height: 16; radius: 8; color: "#1e333a"; Text { anchors.centerIn: parent; text: Telemetry.gpuTemp + "°C"; color: "#4ecdc4"; font.pixelSize: 9; font.bold: true } } }
                        RowLayout { spacing: 8
                            Canvas { width: 56; height: 56; property int pct: Telemetry.gpuLoad; onPctChanged: requestPaint()
                                onPaint: { var ctx=getContext("2d"); ctx.reset(); ctx.strokeStyle="#2a2a3a"; ctx.lineWidth=4; ctx.beginPath(); ctx.arc(28,28,22,0,Math.PI*2); ctx.stroke(); ctx.strokeStyle="#4ecdc4"; ctx.beginPath(); ctx.arc(28,28,22,-Math.PI/2,-Math.PI/2+Math.PI*2*pct/100); ctx.stroke() }
                            }
                            ColumnLayout { spacing: 1
                                Text { text: Telemetry.gpuLoad + "%"; color: textMain; font.pixelSize: 18; font.bold: true }
                                Text { text: "USAGE"; color: textSub; font.pixelSize: 7 }
                                Text { text: (Telemetry.gpuCoreFreq/1000).toFixed(2) + " GHz"; color: textMain; font.pixelSize: 10 }
                                Text { text: Telemetry.gpuPower.toFixed(0) + " W / " + Telemetry.vramLoad + "% VRAM"; color: textSub; font.pixelSize: 8 }
                            }
                        }
                    }
                }
                Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 130; color: card; radius: 14; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 12; spacing: 6
                        RowLayout { Text { text: "MEMORY"; color: textSub; font.pixelSize: 9; font.bold: true } Item { Layout.fillWidth: true } Rectangle { width: 48; height: 16; radius: 8; color: "#2a2a40"; Text { anchors.centerIn: parent; text: "44°C"; color: textMain; font.pixelSize: 9 } } }
                        RowLayout { spacing: 8
                            Canvas { width: 56; height: 56; property int pct: Telemetry.memUsage; onPctChanged: requestPaint()
                                onPaint: { var ctx=getContext("2d"); ctx.reset(); ctx.strokeStyle="#2a2a3a"; ctx.lineWidth=4; ctx.beginPath(); ctx.arc(28,28,22,0,Math.PI*2); ctx.stroke(); ctx.strokeStyle="#ff6b9d"; ctx.beginPath(); ctx.arc(28,28,22,-Math.PI/2,-Math.PI/2+Math.PI*2*pct/100); ctx.stroke() }
                            }
                            ColumnLayout { spacing: 1
                                Text { text: Telemetry.memUsage + "%"; color: textMain; font.pixelSize: 18; font.bold: true }
                                Text { text: "USAGE"; color: textSub; font.pixelSize: 7 }
                                Text { text: "13.2 GB"; color: textMain; font.pixelSize: 10 }
                                Text { text: "32 GB DDR5-5600"; color: textSub; font.pixelSize: 8 }
                            }
                        }
                    }
                }
                Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 130; color: card; radius: 14; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 12; spacing: 6
                        RowLayout { Text { text: "BATTERY"; color: textSub; font.pixelSize: 9; font.bold: true } Item { Layout.fillWidth: true } Rectangle { width: 48; height: 16; radius: 8; color: "#1e3a2e"; Text { anchors.centerIn: parent; text: "31°C"; color: "#3dd598"; font.pixelSize: 9 } } }
                        RowLayout { spacing: 8
                            Canvas { width: 56; height: 56; property int pct: Telemetry.batPct; onPctChanged: requestPaint()
                                onPaint: { var ctx=getContext("2d"); ctx.reset(); ctx.strokeStyle="#2a2a3a"; ctx.lineWidth=4; ctx.beginPath(); ctx.arc(28,28,22,0,Math.PI*2); ctx.stroke(); ctx.strokeStyle="#3dd598"; ctx.beginPath(); ctx.arc(28,28,22,-Math.PI/2,-Math.PI/2+Math.PI*2*pct/100); ctx.stroke() }
                            }
                            ColumnLayout { spacing: 1
                                Text { text: Telemetry.batPct + "%"; color: textMain; font.pixelSize: 18; font.bold: true }
                                Text { text: "CHARGE"; color: textSub; font.pixelSize: 7 }
                                Text { text: "-22 W"; color: textMain; font.pixelSize: 10 }
                                Text { text: "3h 12m remain"; color: textSub; font.pixelSize: 8 }
                            }
                        }
                    }
                }
            }

            // Hydro + LightBar - stack on narrow
            GridLayout {
                Layout.fillWidth: true
                columns: root.width < 900 ? 1 : 2
                columnSpacing: 10
                rowSpacing: 10

                Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 150; color: card; radius: 14; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 14; spacing: 8
                        RowLayout { Text { text: "Hydro Cooling Loop"; color: textMain; font.bold: true; font.pixelSize: 12 } Item { Layout.fillWidth: true } Text { text: "OASIS Mk2-V4"; color: textSub; font.pixelSize: 9 } }
                        RowLayout { spacing: 12
                            ColumnLayout { Text { text: pumpLabel(Telemetry.waterPump) + " " + pumpPct(Telemetry.waterPump) + "%"; color: textMain; font.bold: true; font.pixelSize: 18 } Text { text: "PUMP SPEED"; color: textSub; font.pixelSize: 7 } }
                            Rectangle { Layout.fillWidth: true; height: 6; radius: 3; color: "#2a2a3a"; Rectangle { width: parent.width * (pumpPct(Telemetry.waterPump)/100); height: parent.height; radius: 3; color: accent } }
                            ColumnLayout { Text { text: Telemetry.waterFan + " RPM"; color: textMain; font.bold: true; font.pixelSize: 13 } Text { text: "RADIATOR"; color: textSub; font.pixelSize: 7 } }
                        }
                        RowLayout { spacing: 6
                            Repeater { model: [{l:"COOLANT",v:"38.2°C"},{l:"FLOW",v:"2.1 L/m"},{l:"NOISE",v:"24 dB"}]
                                Rectangle { Layout.fillWidth: true; height: 34; color: "#15151d"; radius: 7; ColumnLayout { anchors.centerIn: parent; spacing: 2; Text { Layout.alignment: Qt.AlignHCenter; text: modelData.l; color: textSub; font.pixelSize: 6 } Text { Layout.alignment: Qt.AlignHCenter; text: modelData.v; color: textMain; font.bold: true; font.pixelSize: 10 } } }
                            }
                        }
                    }
                }
                Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 150; color: card; radius: 14; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 14; spacing: 8
                        Text { text: "Light Bar & Keyboard"; color: textMain; font.bold: true; font.pixelSize: 12 }
                        RowLayout { spacing: 6
                            Repeater { model: ["#6c5cff","#4ecdc4","#ff6b9d","#3dd598","#ffb347"]
                                Rectangle { width: 28; height: 28; radius: 14; color: modelData; border.color: index===0?"white":"transparent"; border.width: 2 }
                            }
                        }
                        Rectangle { Layout.fillWidth: true; height: 6; radius: 3; color: "#2a2a3a"; Rectangle { width: parent.width*0.8; height: parent.height; radius: 3; color: accent } }
                        GridLayout { columns: 4; columnSpacing: 6; Layout.fillWidth: true
                            Repeater { model: ["Static","Wave","Breath","Rainbow"]
                                Rectangle { Layout.fillWidth: true; height: 22; radius: 8; color: index===1?accent:"#252530"; Text { anchors.centerIn: parent; text: modelData; color: index===1?"white":textSub; font.pixelSize: 8 } }
                            }
                        }
                    }
                }
            }
        }
    }
}
