import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent

    property color bg: "#0f0f13"
    property color card: "#1a1a24"
    property color cardBorder: "#252530"
    property color textMain: "#e8e8f0"
    property color textSub: "#7a7a90"
    property color accent: "#6c5cff"
    property color accent2: "#3dd598"
    property color accentCPU: "#7c6cff"
    property color accentGPU: "#4ecdc4"
    property color accentMEM: "#ff6b9d"
    property color accentBAT: "#3dd598"

    // Circular Progress Component
    Component {
        id: circProgress
        Item {
            property int percent: 42
            property color col: "#6c5cff"
            width: 96; height: 96
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()
                    ctx.lineWidth = 6
                    // bg
                    ctx.beginPath()
                    ctx.strokeStyle = "#2a2a3a"
                    ctx.arc(width/2, height/2, 38, -Math.PI*0.75, Math.PI*0.75, false)
                    ctx.stroke()
                    // fg
                    ctx.beginPath()
                    ctx.strokeStyle = col
                    ctx.lineCap = "round"
                    var end = -Math.PI*0.75 + (Math.PI*1.5 * percent/100)
                    ctx.arc(width/2, height/2, 38, -Math.PI*0.75, end, false)
                    ctx.stroke()
                }
            }
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 0
                Text { Layout.alignment: Qt.AlignHCenter; text: parent.parent.percent + "%"; color: textMain; font.pixelSize: 22; font.bold: true }
                Text { Layout.alignment: Qt.AlignHCenter; text: "USAGE"; color: textSub; font.pixelSize: 9; font.letterSpacing: 1 }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16

        // Header
        RowLayout {
            Layout.fillWidth: true
            ColumnLayout {
                spacing: 4
                Text { text: "Dashboard"; color: textMain; font.pixelSize: 28; font.bold: true }
                Text { text: "Telemetry • XMG NEO A25 • CachyOS Linux 6.12 • Ryzen 9 9955HX3D • tick " + (Telemetry.cpuTemp % 10); color: textSub; font.pixelSize: 12 }
            }
            Item { Layout.fillWidth: true }
            Rectangle { width: 160; height: 36; radius: 18; color: card; border.color: cardBorder; border.width: 1
                RowLayout { anchors.centerIn: parent; spacing: 6
                    Text { text: "⚡"; color: textSub }
                    Text { text: "Live Monitoring"; color: textMain; font.pixelSize: 12; font.bold: true }
                }
            }
            Rectangle { width: 100; height: 36; radius: 18; color: accent
                RowLayout { anchors.centerIn: parent; spacing: 6
                    Text { text: "⚡"; color: "white" }
                    Text { text: "Presets"; color: "white"; font.pixelSize: 12; font.bold: true }
                }
            }
        }

        // Top 4 Cards Row
        GridLayout {
            Layout.fillWidth: true
            columns: 4
            columnSpacing: 16
            rowSpacing: 16

            // CPU CARD
            Rectangle {
                Layout.fillWidth: true; Layout.preferredHeight: 160; color: card; radius: 20; border.color: cardBorder; border.width: 1
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 16; spacing: 12
                    RowLayout {
                        Rectangle { width: 32; height: 32; radius: 8; color: "#252540"
                            Text { anchors.centerIn: parent; text: "⚙"; font.pixelSize: 16 }
                        }
                        ColumnLayout { spacing: 0
                            Text { text: "CPU"; color: textSub; font.pixelSize: 10; font.letterSpacing: 1 }
                            Text { text: "Ryzen 9 9955HX3D"; color: textMain; font.pixelSize: 13 }
                        }
                        Item { Layout.fillWidth: true }
                        Rectangle { width: 54; height: 22; radius: 11; color: "#232330"
                            Text { anchors.centerIn: parent; text: "🌡 " + Telemetry.cpuTemp + "°C"; color: textMain; font.pixelSize: 11 }
                        }
                    }
                    RowLayout {
                        spacing: 16
                        Loader { sourceComponent: circProgress; property int percent: 42; property color col: accentCPU
                            onLoaded: { item.percent = Math.min(100, Telemetry.cpuFanPct + 10); item.col = accentCPU }
                        }
                        ColumnLayout { spacing: 8
                            RowLayout { Text { text: "CLOCK"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 50 } Text { text: (Telemetry.cpuFreq/1000).toFixed(2) + " GHz"; color: textMain; font.pixelSize: 13 } }
                            RowLayout { Text { text: "POWER"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 50 } Text { text: Telemetry.cpuPower.toFixed(0) + " W"; color: textMain; font.pixelSize: 13 } }
                            RowLayout { Text { text: "TDP"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 50 } Text { text: "170 W"; color: textMain; font.pixelSize: 13 } }
                            Rectangle { Layout.fillWidth: true; height: 4; radius: 2; color: "#2a2a3a"
                                Rectangle { width: parent.width * 0.42; height: parent.height; radius: 2; color: accentCPU }
                            }
                        }
                    }
                }
            }
            // GPU CARD
            Rectangle {
                Layout.fillWidth: true; Layout.preferredHeight: 160; color: card; radius: 20; border.color: cardBorder; border.width: 1
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 16; spacing: 12
                    RowLayout {
                        Rectangle { width: 32; height: 32; radius: 8; color: "#1e333a"
                            Text { anchors.centerIn: parent; text: "🎮"; font.pixelSize: 16 }
                        }
                        ColumnLayout { spacing: 0
                            Text { text: "GPU"; color: textSub; font.pixelSize: 10; font.letterSpacing: 1 }
                            Text { text: "RTX 5090 Laptop 24GB"; color: textMain; font.pixelSize: 13 }
                        }
                        Item { Layout.fillWidth: true }
                        Rectangle { width: 54; height: 22; radius: 11; color: "#232330"
                            Text { anchors.centerIn: parent; text: "🌡 " + Telemetry.gpuTemp + "°C"; color: textMain; font.pixelSize: 11 }
                        }
                    }
                    RowLayout {
                        spacing: 16
                        Loader { sourceComponent: circProgress; property int percent: 32; property color col: accentGPU
                            onLoaded: { item.percent = Telemetry.gpuLoad; item.col = accentGPU }
                        }
                        ColumnLayout { spacing: 8
                            RowLayout { Text { text: "CLOCK"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 50 } Text { text: (Telemetry.gpuCoreFreq/1000).toFixed(2) + " GHz"; color: textMain; font.pixelSize: 13 } }
                            RowLayout { Text { text: "POWER"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 50 } Text { text: Telemetry.gpuPower.toFixed(0) + " W"; color: textMain; font.pixelSize: 13 } }
                            RowLayout { Text { text: "VRAM"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 50 } Text { text: Telemetry.vramLoad + "% / 24 GB"; color: textMain; font.pixelSize: 13 } }
                            Rectangle { Layout.fillWidth: true; height: 4; radius: 2; color: "#2a2a3a"
                                Rectangle { width: parent.width * (Telemetry.gpuLoad/100); height: parent.height; radius: 2; color: accentGPU }
                            }
                        }
                    }
                }
            }
            // MEMORY CARD
            Rectangle {
                Layout.fillWidth: true; Layout.preferredHeight: 160; color: card; radius: 20; border.color: cardBorder; border.width: 1
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 16; spacing: 12
                    RowLayout {
                        Rectangle { width: 32; height: 32; radius: 8; color: "#3a1e2e"
                            Text { anchors.centerIn: parent; text: "🧠"; font.pixelSize: 16 }
                        }
                        ColumnLayout { spacing: 0
                            Text { text: "MEMORY"; color: textSub; font.pixelSize: 10; font.letterSpacing: 1 }
                            Text { text: "DDR5-5600 Dual Channel"; color: textMain; font.pixelSize: 12 }
                        }
                        Item { Layout.fillWidth: true }
                        Rectangle { width: 54; height: 22; radius: 11; color: "#232330"
                            Text { anchors.centerIn: parent; text: "🌡 44°C"; color: textMain; font.pixelSize: 11 }
                        }
                    }
                    RowLayout {
                        spacing: 16
                        Loader { sourceComponent: circProgress; onLoaded: { item.percent = 42; item.col = accentMEM } }
                        ColumnLayout { spacing: 8
                            RowLayout { Text { text: "USED"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 50 } Text { text: "13.2 GB"; color: textMain; font.pixelSize: 13 } }
                            RowLayout { Text { text: "TOTAL"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 50 } Text { text: "32 GB"; color: textMain; font.pixelSize: 13 } }
                            RowLayout { Text { text: "SPEED"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 50 } Text { text: "5600 MT/s"; color: textMain; font.pixelSize: 13 } }
                            Rectangle { Layout.fillWidth: true; height: 4; radius: 2; color: "#2a2a3a"
                                Rectangle { width: parent.width * 0.42; height: parent.height; radius: 2; color: accentMEM }
                            }
                        }
                    }
                }
            }
            // BATTERY CARD
            Rectangle {
                Layout.fillWidth: true; Layout.preferredHeight: 160; color: card; radius: 20; border.color: cardBorder; border.width: 1
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 16; spacing: 12
                    RowLayout {
                        Rectangle { width: 32; height: 32; radius: 8; color: "#1e3a2e"
                            Text { anchors.centerIn: parent; text: "🔋"; font.pixelSize: 16 }
                        }
                        ColumnLayout { spacing: 0
                            Text { text: "BATTERY"; color: textSub; font.pixelSize: 10; font.letterSpacing: 1 }
                            Text { text: "99 Wh • Charging"; color: textMain; font.pixelSize: 12 }
                        }
                        Item { Layout.fillWidth: true }
                        Rectangle { width: 54; height: 22; radius: 11; color: "#232330"
                            Text { anchors.centerIn: parent; text: "🌡 31°C"; color: textMain; font.pixelSize: 11 }
                        }
                    }
                    RowLayout {
                        spacing: 16
                        Loader { sourceComponent: circProgress; onLoaded: { item.percent = 87; item.col = accentBAT } }
                        ColumnLayout { spacing: 8
                            RowLayout { Text { text: "RATE"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 60 } Text { text: "-22 W"; color: textMain; font.pixelSize: 13 } }
                            RowLayout { Text { text: "REMAIN"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 60 } Text { text: "3h 12m"; color: textMain; font.pixelSize: 13 } }
                            RowLayout { Text { text: "HEALTH"; color: textSub; font.pixelSize: 10; Layout.preferredWidth: 60 } Text { text: "97%"; color: textMain; font.pixelSize: 13 } }
                            Rectangle { Layout.fillWidth: true; height: 4; radius: 2; color: "#2a2a3a"
                                Rectangle { width: parent.width * 0.87; height: parent.height; radius: 2; color: accentBAT }
                            }
                        }
                    }
                }
            }
        }

        // Bottom Row - Hydro + Light Bar
        GridLayout {
            Layout.fillWidth: true
            columns: 2
            columnSpacing: 16
            rowSpacing: 16

            // Hydro Cooling Loop
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true; Layout.preferredHeight: 260; color: card; radius: 20; border.color: cardBorder; border.width: 1
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 20; spacing: 16
                    RowLayout {
                        Rectangle { width: 36; height: 36; radius: 10; color: "#252540"
                            Text { anchors.centerIn: parent; text: "💧"; font.pixelSize: 18 }
                        }
                        ColumnLayout { spacing: 0
                            Text { text: "Hydro Cooling Loop"; color: textMain; font.pixelSize: 16; font.bold: true }
                            Text { text: "OASIS Mk III • External radiator"; color: textSub; font.pixelSize: 12 }
                        }
                        Item { Layout.fillWidth: true }
                        Rectangle { width: 64; height: 28; radius: 14; color: "#252530"
                            Text { anchors.centerIn: parent; text: "Open >"; color: textMain; font.pixelSize: 12 }
                        }
                    }
                    RowLayout {
                        spacing: 20
                        // Pump Circle
                        Item { width: 130; height: 130
                            Canvas {
                                anchors.fill: parent
                                onPaint: {
                                    var ctx = getContext("2d")
                                    ctx.reset()
                                    ctx.fillStyle = "#1e1e30"
                                    ctx.beginPath(); ctx.arc(65,65,60,0,Math.PI*2); ctx.fill()
                                    ctx.fillStyle = "#3a2a6a"
                                    ctx.beginPath()
                                    var pct = Telemetry.waterPump/100
                                    var h = 120 * pct
                                    ctx.rect(5, 120-h, 120, h)
                                    ctx.fill()
                                }
                            }
                            ColumnLayout { anchors.centerIn: parent; spacing: 0
                                Text { Layout.alignment: Qt.AlignHCenter; text: Telemetry.waterPump + "%"; color: textMain; font.pixelSize: 32; font.bold: true }
                                Text { Layout.alignment: Qt.AlignHCenter; text: "PUMP SPEED"; color: textSub; font.pixelSize: 10; font.letterSpacing: 1 }
                            }
                            RowLayout { anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter; spacing: 4
                                Repeater { model: 3; Rectangle { width: 32; height: 18; radius: 9; color: "#252530"; Text { anchors.centerIn: parent; text: ["38°","42°","36°"][index]; color: textMain; font.pixelSize: 10 } } }
                            }
                        }
                        ColumnLayout { Layout.fillWidth: true; spacing: 24
                            ColumnLayout { spacing: 8
                                RowLayout { Text { text: "Pump"; color: textSub; font.pixelSize: 13 } Item { Layout.fillWidth: true } Rectangle { width: 40; height: 22; radius: 6; color: "#252530"; Text { anchors.centerIn: parent; text: Telemetry.waterPump + "%"; color: textMain; font.pixelSize: 12 } } }
                                Rectangle { Layout.fillWidth: true; height: 6; radius: 3; color: "#2a2a3a"
                                    Rectangle { width: parent.width * (Telemetry.waterPump/100); height: parent.height; radius: 3; color: accent }
                                    Rectangle { x: parent.width * (Telemetry.waterPump/100) - 8; y: -5; width: 16; height: 16; radius: 8; color: "white"; border.color: "#444"; border.width: 1 }
                                }
                            }
                            ColumnLayout { spacing: 8
                                RowLayout { Text { text: "Radiator Fans"; color: textSub; font.pixelSize: 13 } Item { Layout.fillWidth: true } Rectangle { width: 40; height: 22; radius: 6; color: "#252530"; Text { anchors.centerIn: parent; text: Math.round(Telemetry.waterFan/1.5) + "%"; color: textMain; font.pixelSize: 12 } } }
                                Rectangle { Layout.fillWidth: true; height: 6; radius: 3; color: "#2a2a3a"
                                    Rectangle { width: parent.width * 0.64; height: parent.height; radius: 3; color: accent }
                                    Rectangle { x: parent.width * 0.64 - 8; y: -5; width: 16; height: 16; radius: 8; color: "white"; border.color: "#444"; border.width: 1 }
                                }
                            }
                            RowLayout { spacing: 12
                                Rectangle { Layout.fillWidth: true; height: 54; radius: 10; color: "#15151d"
                                    ColumnLayout { anchors.fill: parent; anchors.margins: 10; spacing: 2
                                        Text { text: "COOLANT"; color: textSub; font.pixelSize: 9; font.letterSpacing: 1 }
                                        Text { text: "38.2°C"; color: textMain; font.pixelSize: 14; font.bold: true }
                                    }
                                }
                                Rectangle { Layout.fillWidth: true; height: 54; radius: 10; color: "#15151d"
                                    ColumnLayout { anchors.fill: parent; anchors.margins: 10; spacing: 2
                                        Text { text: "FLOW"; color: textSub; font.pixelSize: 9; font.letterSpacing: 1 }
                                        Text { text: "2.1 L/m"; color: textMain; font.pixelSize: 14; font.bold: true }
                                    }
                                }
                                Rectangle { Layout.fillWidth: true; height: 54; radius: 10; color: "#15151d"
                                    ColumnLayout { anchors.fill: parent; anchors.margins: 10; spacing: 2
                                        Text { text: "NOISE"; color: textSub; font.pixelSize: 9; font.letterSpacing: 1 }
                                        Text { text: "24 dB"; color: textMain; font.pixelSize: 14; font.bold: true }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Light Bar & Keyboard
            Rectangle {
                Layout.fillWidth: true; Layout.preferredWidth: 360; Layout.fillHeight: true; Layout.preferredHeight: 260; color: card; radius: 20; border.color: cardBorder; border.width: 1
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 20; spacing: 16
                    RowLayout {
                        Rectangle { width: 36; height: 36; radius: 10; color: "#3a1e2e"
                            Text { anchors.centerIn: parent; text: "🎨"; font.pixelSize: 18 }
                        }
                        ColumnLayout { spacing: 0
                            Text { text: "Light Bar & Keyboard"; color: textMain; font.pixelSize: 16; font.bold: true }
                            Text { text: "Per-key + 28 zone bar"; color: textSub; font.pixelSize: 12 }
                        }
                        Item { Layout.fillWidth: true }
                    }
                    ColumnLayout { spacing: 12
                        RowLayout {
                            Text { text: "Color"; color: textSub; font.pixelSize: 13 }
                            Item { Layout.fillWidth: true }
                            Text { text: "#6c5cff"; color: accent; font.pixelSize: 12 }
                        }
                        RowLayout { spacing: 8
                            Repeater { model: ["#6c5cff","#4ecdc4","#ff6b9d","#3dd598","#ffb347","#ffffff"]
                                Rectangle { width: 36; height: 36; radius: 18; color: modelData; border.color: modelData === "#6c5cff" ? "white" : "transparent"; border.width: 2 }
                            }
                            Rectangle { width: 36; height: 36; radius: 18; color: "#252530"; Text { anchors.centerIn: parent; text: "+"; color: textMain; font.pixelSize: 18 } }
                        }
                        RowLayout {
                            Text { text: "Keyboard Brightness"; color: textSub; font.pixelSize: 13 }
                            Item { Layout.fillWidth: true }
                            Rectangle { width: 40; height: 22; radius: 6; color: "#252530"; Text { anchors.centerIn: parent; text: "80%"; color: textMain; font.pixelSize: 12 } }
                        }
                        Rectangle { Layout.fillWidth: true; height: 6; radius: 3; color: "#2a2a3a"
                            Rectangle { width: parent.width * 0.8; height: parent.height; radius: 3; color: accent }
                            Rectangle { x: parent.width * 0.8 - 8; y: -5; width: 16; height: 16; radius: 8; color: "white" }
                        }
                        GridLayout { columns: 4; columnSpacing: 8; rowSpacing: 8; Layout.fillWidth: true
                            Repeater { model: ["Static","Wave","Breathing","Rainbow"]
                                Rectangle { width: 78; height: 32; radius: 8; color: modelData==="Wave" ? accent : "#252530"
                                    Text { anchors.centerIn: parent; text: modelData; color: modelData==="Wave" ? "white" : textSub; font.pixelSize: 11 }
                                }
                            }
                        }
                        Rectangle { Layout.fillWidth: true; height: 44; radius: 12; color: "#15151d"
                            RowLayout { anchors.centerIn: parent; spacing: 4
                                Repeater { model: 14; Rectangle { width: 14; height: 6; radius: 3; color: accent } }
                            }
                        }
                    }
                }
            }
        }

        // Footer
        RowLayout {
            Layout.fillWidth: true
            spacing: 12
            Rectangle { height: 28; width: 160; radius: 14; color: "#1e1e28"; Text { anchors.centerIn: parent; text: "EC Ver: 1.13 • UCU Protocol"; color: textSub; font.pixelSize: 11 } }
            Rectangle { height: 28; width: 260; radius: 14; color: "#1e1e28"; Text { anchors.centerIn: parent; text: "CachyOS Kernel: cachyos-lto 6.12.3"; color: textSub; font.pixelSize: 11 } }
            Rectangle { height: 28; width: 160; radius: 14; color: "#1e2e28"; Text { anchors.centerIn: parent; text: "No thermal throttling"; color: "#3dd598"; font.pixelSize: 11 } }
            Item { Layout.fillWidth: true }
        }
    }
}
