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
    property color accent2: "#4ecdc4"

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
        anchors.margins: 16
        contentHeight: contentCol.implicitHeight + 20
        clip: false

        ColumnLayout {
            id: contentCol
            width: parent.width
            spacing: 14

            Text { text: "Fan Control"; color: textMain; font.pixelSize: 22; font.bold: true; Layout.fillWidth: true }
            Text { text: "UCU-style curve editor. CPU & GPU separate."; color: textSub; font.pixelSize: 11; Layout.fillWidth: true }

            // Manual Override - auto height
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: manualCol.implicitHeight + 32
                color: card; radius: 14; border.color: cardBorder; border.width: 1
                ColumnLayout {
                    id: manualCol
                    anchors.left: parent.left; anchors.right: parent.right; anchors.top: parent.top
                    anchors.margins: 16
                    spacing: 10
                    Text { text: "Manual Override"; color: textMain; font.pixelSize: 13; font.bold: true }
                    ColumnLayout { spacing: 6; Layout.fillWidth: true
                        RowLayout { Text { text: "CPU Fan"; color: textSub; font.pixelSize: 11 } Item { Layout.fillWidth: true } Rectangle { width: 50; height: 20; radius: 6; color: "#2a2a40"; Text { anchors.centerIn: parent; text: Telemetry.cpuFanPct + "%"; color: "white"; font.pixelSize: 11; font.bold: true } } }
                        Rectangle { Layout.fillWidth: true; height: 6; radius: 3; color: "#2a2a3a"; Rectangle { width: parent.width * (Telemetry.cpuFanPct/100); height: parent.height; radius: 3; color: accent } Rectangle { x: parent.width * (Telemetry.cpuFanPct/100) - 7; y: -4; width: 14; height: 14; radius: 7; color: "white"; border.color: accent; border.width: 2 } }
                    }
                    ColumnLayout { spacing: 6; Layout.fillWidth: true
                        RowLayout { Text { text: "GPU Fan"; color: textSub; font.pixelSize: 11 } Item { Layout.fillWidth: true } Rectangle { width: 50; height: 20; radius: 6; color: "#2a2a40"; Text { anchors.centerIn: parent; text: Telemetry.gpuFanPct + "%"; color: "white"; font.pixelSize: 11; font.bold: true } } }
                        Rectangle { Layout.fillWidth: true; height: 6; radius: 3; color: "#2a2a3a"; Rectangle { width: parent.width * (Telemetry.gpuFanPct/100); height: parent.height; radius: 3; color: accent } Rectangle { x: parent.width * (Telemetry.gpuFanPct/100) - 7; y: -4; width: 14; height: 14; radius: 7; color: "white"; border.color: accent; border.width: 2 } }
                    }
                    ColumnLayout { spacing: 6; Layout.fillWidth: true
                        RowLayout { Text { text: "OASIS Pump"; color: textSub; font.pixelSize: 11 } Item { Layout.fillWidth: true } Rectangle { width: 90; height: 20; radius: 6; color: "#2a2a40"; Text { anchors.centerIn: parent; text: pumpLabel(Telemetry.waterPump) + " " + pumpPct(Telemetry.waterPump) + "%"; color: "white"; font.pixelSize: 10; font.bold: true } } }
                        Rectangle { Layout.fillWidth: true; height: 6; radius: 3; color: "#2a2a3a"; Rectangle { width: parent.width * (pumpPct(Telemetry.waterPump)/100); height: parent.height; radius: 3; color: accent } }
                    }
                }
            }

            // Acoustic Profile - FIXED HEIGHT NO OVERLAP
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: acousticCol.implicitHeight + 32
                color: "#1e1e32"
                radius: 14
                border.color: "#3a3a5a"
                border.width: 1
                ColumnLayout {
                    id: acousticCol
                    anchors.left: parent.left; anchors.right: parent.right; anchors.top: parent.top
                    anchors.margins: 16
                    spacing: 10
                    Text { text: "Acoustic Profile"; color: "#ffffff"; font.pixelSize: 13; font.bold: true }

                    Rectangle { Layout.fillWidth: true; height: 40; radius: 10; color: "#252538"
                        RowLayout { anchors.fill: parent; anchors.margins: 10
                            Rectangle { width: 26; height: 26; radius: 7; color: "#2a2a3a"; Text { anchors.centerIn: parent; text: "🔇"; font.pixelSize: 12 } }
                            Text { text: "Silent"; color: "#d0d0e8"; font.pixelSize: 12; font.bold: true }
                            Item { Layout.fillWidth: true }
                            Rectangle { width: 52; height: 20; radius: 10; color: "#2a2a40"; Text { anchors.centerIn: parent; text: "22 dB"; color: textSub; font.pixelSize: 10 } }
                        }
                    }
                    Rectangle { Layout.fillWidth: true; height: 40; radius: 10; color: "#2a224a"; border.color: accent; border.width: 1.5
                        RowLayout { anchors.fill: parent; anchors.margins: 10
                            Rectangle { width: 26; height: 26; radius: 7; color: accent; Text { anchors.centerIn: parent; text: "🎧"; font.pixelSize: 12 } }
                            Text { text: "Balanced"; color: "white"; font.pixelSize: 12; font.bold: true }
                            Item { Layout.fillWidth: true }
                            Rectangle { width: 84; height: 20; radius: 10; color: accent; Text { anchors.centerIn: parent; text: "28 dB • Active"; color: "white"; font.pixelSize: 9; font.bold: true } }
                        }
                    }
                    Rectangle { Layout.fillWidth: true; height: 40; radius: 10; color: "#252538"
                        RowLayout { anchors.fill: parent; anchors.margins: 10
                            Rectangle { width: 26; height: 26; radius: 7; color: "#3a2a1a"; Text { anchors.centerIn: parent; text: "🚀"; font.pixelSize: 12 } }
                            Text { text: "Performance"; color: "#d0d0e8"; font.pixelSize: 12; font.bold: true }
                            Item { Layout.fillWidth: true }
                            Rectangle { width: 52; height: 20; radius: 10; color: "#2a2a40"; Text { anchors.centerIn: parent; text: "38 dB"; color: textSub; font.pixelSize: 10 } }
                        }
                    }
                }
            }

            // OASIS
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 64
                color: card; radius: 12; border.color: accent; border.width: 1.2
                RowLayout {
                    anchors.fill: parent; anchors.margins: 12; spacing: 10
                    Rectangle { width: 32; height: 32; radius: 8; color: "#2a1e4a"; Text { anchors.centerIn: parent; text: "💧"; font.pixelSize: 16 } }
                    ColumnLayout { spacing: 2
                        Text { text: "OASIS Mk2-V4"; color: textMain; font.bold: true; font.pixelSize: 12 }
                        Text { text: Telemetry.waterFan + " RPM • " + pumpLabel(Telemetry.waterPump) + " " + pumpPct(Telemetry.waterPump) + "% pump"; color: accent; font.pixelSize: 10; font.bold: true }
                    }
                    Item { Layout.fillWidth: true }
                    Rectangle { width: 8; height: 8; radius: 4; color: "#3dd598" }
                }
            }

            // CPU & GPU Curves
            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                Rectangle {
                    Layout.fillWidth: true; implicitHeight: 300; color: card; radius: 14; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 12; spacing: 8
                        RowLayout { Text { text: "CPU Fan Curve"; color: textMain; font.bold: true; font.pixelSize: 11 } Rectangle { width: 70; height: 16; radius: 8; color: "#1e3a2e"; Text { anchors.centerIn: parent; text: "CPU " + Telemetry.cpuTemp + "°C"; color: "#3dd598"; font.pixelSize: 8 } } Item { Layout.fillWidth: true } }
                        Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 160; color: "#0f0f14"; radius: 8
                            Canvas { anchors.fill: parent; anchors.margins: 8
                                onPaint: {
                                    var ctx=getContext("2d"); ctx.reset(); var w=width,h=height
                                    ctx.strokeStyle="#1e1e2a"; ctx.setLineDash([3,4]); for(var i=1;i<4;i++){ ctx.beginPath(); ctx.moveTo(0,h*i/4); ctx.lineTo(w,h*i/4); ctx.stroke(); } ctx.setLineDash([])
                                    var pts=[{t:0,f:25},{t:25,f:32},{t:50,f:48},{t:75,f:72},{t:100,f:100}]
                                    ctx.strokeStyle="#6c5cff"; ctx.lineWidth=2; ctx.beginPath(); for(var j=0;j<pts.length;j++){ var x=(pts[j].t/100)*w, y=h-(pts[j].f/100)*h; if(j===0) ctx.moveTo(x,y); else { var px=(pts[j-1].t/100)*w, py=h-(pts[j-1].f/100)*h, cx=(px+x)/2; ctx.bezierCurveTo(cx,py,cx,y,x,y) } } ctx.stroke()
                                    for(var k=0;k<pts.length;k++){ var pkx=(pts[k].t/100)*w, pky=h-(pts[k].f/100)*h; ctx.fillStyle="white"; ctx.strokeStyle="#6c5cff"; ctx.beginPath(); ctx.arc(pkx,pky,4,0,Math.PI*2); ctx.fill(); ctx.stroke() }
                                }
                            }
                        }
                        RowLayout { spacing: 4; Layout.fillWidth: true
                            Repeater { model: ["0°/25%","25°/32%","50°/48%","75°/72%","100°/100%"]
                                Rectangle { Layout.fillWidth: true; height: 28; color: "#15151d"; radius: 5; Text { anchors.centerIn: parent; text: modelData; color: textMain; font.pixelSize: 6; font.bold: true } }
                            }
                        }
                    }
                }
                Rectangle {
                    Layout.fillWidth: true; implicitHeight: 300; color: card; radius: 14; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 12; spacing: 8
                        RowLayout { Text { text: "GPU Fan Curve"; color: textMain; font.bold: true; font.pixelSize: 11 } Rectangle { width: 70; height: 16; radius: 8; color: "#1e333a"; Text { anchors.centerIn: parent; text: "GPU " + Telemetry.gpuTemp + "°C"; color: "#4ecdc4"; font.pixelSize: 8 } } Item { Layout.fillWidth: true } }
                        Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 160; color: "#0f0f14"; radius: 8
                            Canvas { anchors.fill: parent; anchors.margins: 8
                                onPaint: {
                                    var ctx=getContext("2d"); ctx.reset(); var w=width,h=height
                                    ctx.strokeStyle="#1e1e2a"; ctx.setLineDash([3,4]); for(var i=1;i<4;i++){ ctx.beginPath(); ctx.moveTo(0,h*i/4); ctx.lineTo(w,h*i/4); ctx.stroke(); } ctx.setLineDash([])
                                    var pts=[{t:0,f:20},{t:30,f:30},{t:55,f:45},{t:75,f:68},{t:100,f:100}]
                                    ctx.strokeStyle="#4ecdc4"; ctx.lineWidth=2; ctx.beginPath(); for(var j=0;j<pts.length;j++){ var x=(pts[j].t/100)*w, y=h-(pts[j].f/100)*h; if(j===0) ctx.moveTo(x,y); else { var px=(pts[j-1].t/100)*w, py=h-(pts[j-1].f/100)*h, cx=(px+x)/2; ctx.bezierCurveTo(cx,py,cx,y,x,y) } } ctx.stroke()
                                    for(var k=0;k<pts.length;k++){ var pkx=(pts[k].t/100)*w, pky=h-(pts[k].f/100)*h; ctx.fillStyle="white"; ctx.strokeStyle="#4ecdc4"; ctx.beginPath(); ctx.arc(pkx,pky,4,0,Math.PI*2); ctx.fill(); ctx.stroke() }
                                }
                            }
                        }
                        RowLayout { spacing: 4; Layout.fillWidth: true
                            Repeater { model: ["0°/20%","30°/30%","55°/45%","75°/68%","100°/100%"]
                                Rectangle { Layout.fillWidth: true; height: 28; color: "#15151d"; radius: 5; Text { anchors.centerIn: parent; text: modelData; color: textMain; font.pixelSize: 6; font.bold: true } }
                            }
                        }
                    }
                }
            }
        }
    }
}
