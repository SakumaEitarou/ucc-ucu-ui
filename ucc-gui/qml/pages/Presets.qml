
import QtQuick 2.15
import QtQuick.Layouts 1.15
ColumnLayout { spacing: 16
    Text { text: "Presets"; color: "white"; font.pixelSize: 26; font.bold: true }
    RowLayout { spacing: 12
        Repeater { model: ["Office","Gaming","Turbo"]
            delegate: Rectangle { width: 180; height: 100; radius: 14; color: index==1?"#6c5cff":"#24242e"; border.color: "#3a3a50"
                Column { anchors.centerIn: parent; Text { text: modelData; color: "white"; font.bold: true; font.pixelSize: 16; anchors.horizontalCenter: parent.horizontalCenter } Text { text: index==0?"35W":""+(120+index*45)+"W"; color: "#bbb"; anchors.horizontalCenter: parent.horizontalCenter } }
            }
        }
    }
    Text { text: "Custom Presets (up to 5) - подключи к libucc-dbus: dbus.getProfiles()"; color: "#666"; font.pixelSize: 12 }
}
