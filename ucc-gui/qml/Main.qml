import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15

Window {
    id: root
    width: 1280; height: 720; visible: true
    title: "UCC - XMG Neo A25 UCU Edition"
    color: "#1a1a23"
    property string currentPage: "Dashboard"
    property color accent: "#6c5cff"
    property color bg: "#1a1a23"

    RowLayout { anchors.fill: parent; spacing: 0
        Rectangle { Layout.preferredWidth: 220; Layout.fillHeight: true; color: "#12121a"
            ColumnLayout { anchors.fill: parent; anchors.margins: 12; spacing: 8
                RowLayout { spacing: 8
                    Rectangle { width: 32; height: 32; radius: 8; color: root.accent
                        Text { anchors.centerIn: parent; text: "U"; color: "white"; font.bold: true; font.pixelSize: 16 }
                    }
                    ColumnLayout { spacing: 0
                        Text { text: "UCC"; color: "white"; font.bold: true; font.pixelSize: 14 }
                        Text { text: "NEO A25 / CachyOS"; color: "#8a8aa0"; font.pixelSize: 10 }
                    }
                }
                Item { height: 12 }
                ListView { Layout.fillWidth: true; Layout.preferredHeight: 300
                    model: ["Dashboard","Presets","Fan Control","Hydro UI","Keyboard","Light Bar"]
                    delegate: Rectangle {
                        width: ListView.view.width; height: 44; radius: 10
                        color: root.currentPage === modelData ? "#2f2a5a" : "transparent"
                        border.color: root.currentPage === modelData ? root.accent : "transparent"; border.width: 1
                        Text { anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; anchors.leftMargin: 12; text: modelData; color: root.currentPage === modelData ? "white" : "#c5c5d6"; font.pixelSize: 13 }
                        MouseArea { anchors.fill: parent; onClicked: root.currentPage = modelData }
                    }
                }
                Item { Layout.fillHeight: true }
                Text { text: "CPU " + Telemetry.cpuTemp + "°  GPU " + Telemetry.gpuTemp + "°  LIQ " + Telemetry.waterFan + " RPM"; color: "#6c5cff"; font.pixelSize: 11 }
            }
        }
        Rectangle { Layout.fillWidth: true; Layout.fillHeight: true; color: root.bg
            Loader { anchors.fill: parent; anchors.margins: 24
                source: {
                    if(root.currentPage==="Dashboard") return "pages/Dashboard.qml"
                    if(root.currentPage==="Hydro UI") return "pages/Hydro.qml"
                    if(root.currentPage==="Presets") return "pages/Presets.qml"
                    if(root.currentPage==="Fan Control") return "pages/FanControl.qml"
                    if(root.currentPage==="Keyboard") return "pages/Keyboard.qml"
                    if(root.currentPage==="Light Bar") return "pages/LightBar.qml"
                    return "pages/Dashboard.qml"
                }
            }
        }
    }
}
