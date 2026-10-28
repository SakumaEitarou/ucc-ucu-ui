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
    property color accent2: "#4ecdc4"

    function pumpPct(v) {
        if(v<=0) return 66
        if(v===1) return 33
        if(v===2) return 66
        if(v===3) return 100
        return v
    }
    function pumpLabel(v) {
        if(v===0) return "Med"
        if(v===1) return "Low"
        if(v===2) return "Med"
        if(v===3) return "High"
        return v + "%"
    }

    Flickable {
        anchors.fill: parent
        anchors.margins: 20
        contentHeight: col.height
        clip: true

        ColumnLayout {
            id: col
            width: parent.width
            spacing: 16

            // Header
            RowLayout {
                Layout.fillWidth: true
                ColumnLayout {
                    Text { text: "Fan Control"; color: textMain; font.pixelSize: 24; font.bold: true }
                    Text { text: "UCU-style curve editor. CPU & GPU separate."; color: textSub; font.pixelSize: 11 }
                }
                Item { Layout.fillWidth: true }
                Rectangle { width: 90; height: 28; radius: 14; color: accent
                    Text { anchors.centerIn: parent; text: "CPU / GPU"; color: "white"; font.pixelSize: 11; font.bold: true }
                }
            }

            // Manual Override - TOP, full width, no overlap
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                color: card; radius: 16; border.color: cardBorder; border.width: 1
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 18; spacing: 10
                    Text { text: "Manual Override"; color: textMain; font.pixelSize: 13; font.bold: true }
                    ColumnLayout { spacing: 8; Layout.fillWidth: true
                        RowLayout { Text { text: "CPU Fan"; color: textSub; font.pixelSize: 11 } Item { Layout.fillWidth: true } Rectangle { width: 44; height: 20; radius: 6; color: "#252530"; Text { anchors.centerIn: parent; text: Telemetry.cpuFanPct + "%"; color: textMain; font.pixelSize: 11 } } }
                        Rectangle { Layout.fillWidth: true; height: 5; radius: 3; color: "#2a2a3a"; Rectangle { width: parent.width * (Telemetry.cpuFanPct/100); height: parent.height; radius: 3; color: accent } Rectangle { x: parent.width * (Telemetry.cpuFanPct/100) - 7; y: -4; width: 14; height: 14; radius: 7; color: "white" } }
                    }
                    ColumnLayout { spacing: 8; Layout.fillWidth: true
                        RowLayout { Text { text: "GPU Fan"; color: textSub; font.pixelSize: 11 } Item { Layout.fillWidth: true } Rectangle { width: 44; height: 20; radius: 6; color: "#252530"; Text { anchors.centerIn: parent; text: Telemetry.gpuFanPct + "%"; color: textMain; font.pixelSize: 11 } } }
                        Rectangle { Layout.fillWidth: true; height: 5; radius: 3; color: "#2a2a3a"; Rectangle { width: parent.width * (Telemetry.gpuFanPct/100); height: parent.height; radius: 3; color: accent } Rectangle { x: parent.width * (Telemetry.gpuFanPct/100) - 7; y: -4; width: 14; height: 14; radius: 7; color: "white" } }
                    }
                    ColumnLayout { spacing: 8; Layout.fillWidth: true
                        RowLayout { Text { text: "OASIS Pump"; color: textSub; font.pixelSize: 11 } Item { Layout.fillWidth: true } Rectangle { width: 80; height: 20; radius: 6; color: "#252530"; Text { anchors.centerIn: parent; text: pumpLabel(Telemetry.waterPump) + " " + pumpPct(Telemetry.waterPump) + "%"; color: textMain; font.pixelSize: 10 } } }
                        Rectangle { Layout.fillWidth: true; height: 5; radius: 3; color: "#2a2a3a"; Rectangle { width: parent.width * (pumpPct(Telemetry.waterPump)/100); height: parent.height; radius: 3; color: accent } }
                    }
                }
            }

            // Acoustic + OASIS in one row
            RowLayout {
                Layout.fillWidth: true
                spacing: 12
                Rectangle {
                    Layout.fillWidth: true; Layout.preferredHeight: 120; color: card; radius: 16; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 14; spacing: 8
                        Text { text: "Acoustic Profile"; color: textMain; font.pixelSize: 12; font.bold: true }
                        RowLayout { spacing: 8
                            Rectangle { Layout.fillWidth: true; height: 28; radius: 8; color: "#1e1e28"; Text { anchors.centerIn: parent; text: "Silent 22 dB"; color: textSub; font.pixelSize: 10 } }
                            Rectangle { Layout.fillWidth: true; height: 28; radius: 8; color: "#252540"; border.color: accent; border.width: 1; Text { anchors.centerIn: parent; text: "Balanced 28 dB"; color: textMain; font.pixelSize: 10; font.bold: true } }
                            Rectangle { Layout.fillWidth: true; height: 28; radius: 8; color: "#1e1e28"; Text { anchors.centerIn: parent; text: "Performance 38 dB"; color: textSub; font.pixelSize: 10 } }
                        }
                    }
                }
                Rectangle {
                    Layout.preferredWidth: 320; Layout.preferredHeight: 120; color: card; radius: 16; border.color: accent; border.width: 1
                    RowLayout { anchors.fill: parent; anchors.margins: 14; spacing: 10
                        ColumnLayout { Text { text: "OASIS Mk2-V4"; color: textMain; font.bold: true; font.pixelSize: 12 } Text { text: Telemetry.waterFan + " RPM • " + pumpLabel(Telemetry.waterPump) + " " + pumpPct(Telemetry.waterPump) + "%"; color: accent; font.pixelSize: 10 } }
                        Item { Layout.fillWidth: true }
                        Rectangle { width: 8; height: 8; radius: 4; color: "#3dd598" }
                    }
                }
            }

            // CPU & GPU Curves - SIDE BY SIDE, fixed height, no overlap
            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                // CPU
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 360
                    color: card; radius: 16; border.color: cardBorder; border.width: 1
                    ColumnLayout {
                        anchors.fill: parent; anchors.margins: 14; spacing: 10
                        RowLayout {
                            Text { text: "CPU Fan Curve"; color: textMain; font.pixelSize: 13; font.bold: true }
                            Rectangle { width: 130; height: 18; radius: 9; color: "#1e3a2e"; Text { anchors.centerIn: parent; text: "CPU " + Telemetry.cpuTemp + "°C"; color: "#3dd598"; font.pixelSize: 9 } }
                            Item { Layout.fillWidth: true }
                            Text { text: "Reset"; color: textSub; font.pixelSize: 10 }
                            Rectangle { width: 50; height: 22; radius: 11; color: accent; Text { anchors.centerIn: parent; text: "Apply"; color: "white"; font.pixelSize: 10; font.bold: true } }
                        }
                        Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 180; color: "#0f0f14"; radius: 10
                            Canvas { anchors.fill: parent; anchors.margins: 10
                                onPaint: {
                                    var ctx=getContext("2d"); ctx.reset(); var w=width,h=height
                                    ctx.strokeStyle="#1e1e2a"; ctx.setLineDash([3,4]); for(var i=1;i<4;i++){ ctx.beginPath(); ctx.moveTo(0,h*i/4); ctx.lineTo(w,h*i/4); ctx.stroke(); } ctx.setLineDash([])
                                    var pts=[{t:0,f:25},{t:25,f:32},{t:50,f:48},{t:75,f:72},{t:100,f:100}]
                                    ctx.strokeStyle="#6c5cff"; ctx.lineWidth=2; ctx.beginPath()
                                    for(var j=0;j<pts.length;j++){ var x=(pts[j].t/100)*w, y=h-(pts[j].f/100)*h; if(j===0) ctx.moveTo(x,y); else { var px=(pts[j-1].t/100)*w, py=h-(pts[j-1].f/100)*h, cx=(px+x)/2; ctx.bezierCurveTo(cx,py,cx,y,x,y) } } ctx.stroke()
                                    for(var k=0;k<pts.length;k++){ var pkx=(pts[k].t/100)*w, pky=h-(pts[k].f/100)*h; ctx.fillStyle="white"; ctx.strokeStyle="#6c5cff"; ctx.beginPath(); ctx.arc(pkx,pky,5,0,Math.PI*2); ctx.fill(); ctx.stroke() }
                                }
                            }
                            Text { anchors.left: parent.left; anchors.top: parent.top; anchors.margins: 6; text: "100%"; color: "#3a3a4a"; font.pixelSize: 8 }
                            Text { anchors.left: parent.left; anchors.bottom: parent.bottom; anchors.margins: 6; text: "20°C"; color: "#3a3a4a"; font.pixelSize: 8 }
                            Text { anchors.right: parent.right; anchors.bottom: parent.bottom; anchors.margins: 6; text: "100°C"; color: "#3a3a4a"; font.pixelSize: 8 }
                        }
                        RowLayout { Layout.fillWidth: true; spacing: 6
                            Repeater { model: ["0°/25%","25°/32%","50°/48%","75°/72%","100°/100%"]
                                Rectangle { Layout.fillWidth: true; height: 36; color: "#15151d"; radius: 6
                                    ColumnLayout { anchors.centerIn: parent; spacing: 2
                                        Text { Layout.alignment: Qt.AlignHCenter; text: "P" + (index+1); color: textSub; font.pixelSize: 6 }
                                        Text { Layout.alignment: Qt.AlignHCenter; text: modelData; color: textMain; font.pixelSize: 8; font.bold: true }
                                    }
                                }
                            }
                        }
                    }
                }

                // GPU
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 360
                    color: card; radius: 16; border.color: cardBorder; border.width: 1
                    ColumnLayout {
                        anchors.fill: parent; anchors.margins: 14; spacing: 10
                        RowLayout {
                            Text { text: "GPU Fan Curve"; color: textMain; font.pixelSize: 13; font.bold: true }
                            Rectangle { width: 130; height: 18; radius: 9; color: "#1e333a"; Text { anchors.centerIn: parent; text: "GPU " + Telemetry.gpuTemp + "°C"; color: "#4ecdc4"; font.pixelSize: 9 } }
                            Item { Layout.fillWidth: true }
                            Text { text: "Reset"; color: textSub; font.pixelSize: 10 }
                            Rectangle { width: 50; height: 22; radius: 11; color: accent2; Text { anchors.centerIn: parent; text: "Apply"; color: "white"; font.pixelSize: 10; font.bold: true } }
                        }
                        Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 180; color: "#0f0f14"; radius: 10
                            Canvas { anchors.fill: parent; anchors.margins: 10
                                onPaint: {
                                    var ctx=getContext("2d"); ctx.reset(); var w=width,h=height
                                    ctx.strokeStyle="#1e1e2a"; ctx.setLineDash([3,4]); for(var i=1;i<4;i++){ ctx.beginPath(); ctx.moveTo(0,h*i/4); ctx.lineTo(w,h*i/4); ctx.stroke(); } ctx.setLineDash([])
                                    var pts=[{t:0,f:20},{t:30,f:30},{t:55,f:45},{t:75,f:68},{t:100,f:100}]
                                    ctx.strokeStyle="#4ecdc4"; ctx.lineWidth=2; ctx.beginPath()
                                    for(var j=0;j<pts.length;j++){ var x=(pts[j].t/100)*w, y=h-(pts[j].f/100)*h; if(j===0) ctx.moveTo(x,y); else { var px=(pts[j-1].t/100)*w, py=h-(pts[j-1].f/100)*h, cx=(px+x)/2; ctx.bezierCurveTo(cx,py,cx,y,x,y) } } ctx.stroke()
                                    for(var k=0;k<pts.length;k++){ var pkx=(pts[k].t/100)*w, pky=h-(pts[k].f/100)*h; ctx.fillStyle="white"; ctx.strokeStyle="#4ecdc4"; ctx.beginPath(); ctx.arc(pkx,pky,5,0,Math.PI*2); ctx.fill(); ctx.stroke() }
                                }
                            }
                        }
                        RowLayout { Layout.fillWidth: true; spacing: 6
                            Repeater { model: ["0°/20%","30°/30%","55°/45%","75°/68%","100°/100%"]
                                Rectangle { Layout.fillWidth: true; height: 36; color: "#15151d"; radius: 6
                                    ColumnLayout { anchors.centerIn: parent; spacing: 2
                                        Text { Layout.alignment: Qt.AlignHCenter; text: "P" + (index+1); color: textSub; font.pixelSize: 6 }
                                        Text { Layout.alignment: Qt.AlignHCenter; text: modelData; color: textMain; font.pixelSize: 8; font.bold: true }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
