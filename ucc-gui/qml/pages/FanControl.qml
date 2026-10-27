
import QtQuick 2.15
Column { spacing: 16
    Text { text: "Fan Control"; color: "white"; font.pixelSize: 26; font.bold: true }
    Rectangle { width: 700; height: 300; radius: 16; color: "#24242e"
        Canvas { anchors.fill: parent; anchors.margins: 20
            onPaint: {
                var ctx = getContext("2d"); ctx.strokeStyle = "#6c5cff"; ctx.lineWidth=2; ctx.beginPath();
                ctx.moveTo(0,200); ctx.lineTo(100,180); ctx.lineTo(200,120); ctx.lineTo(400,40); ctx.stroke();
                ctx.fillStyle="#888"; ctx.fillText("Fan curve - перетаскивание точек подключи к uccd.setFanCurve()", 10, 20);
            }
        }
    }
}
