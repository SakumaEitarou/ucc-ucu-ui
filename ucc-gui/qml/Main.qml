import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    visible: true
    width: 1280
    height: 800
    color: "#111115"
    title: "UCC - XMG Neo A25 UCU Edition"
    property string currentPage: "Dashboard"
    property color accent: "#6c5cff"
    property color bg: "#1a1a1f"
    property color card: "#24242e"

    RowLayout {
        anchors.fill: parent
        spacing: 0
        Rectangle {
            Layout.preferredWidth: 260
            Layout.fillHeight: true
            color: "#1e1e28"
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 4
                RowLayout {
                    Layout.bottomMargin: 16
                    Rectangle { width: 36; height: 36; radius: 8; color: root.accent
                        Text { anchors.centerIn: parent; text: "U"; color: "white"; font.bold: true; font.pixelSize: 18 }
                    }
                    Column {
                        Text { text: "UCC"; color: "white"; font.pixelSize: 16; font.bold: true }
                        Text { text: "NEO A25 / CachyOS"; color: "#888"; font.pixelSize: 11 }
                    }
                }
                Repeater {
                    model: ["Dashboard","Presets","Fan Control","Hydro UI","Keyboard","Light Bar"]
                    delegate: Rectangle {
                        Layout.fillWidth: true; height: 44; radius: 10
                        color: root.currentPage === modelData ? "#2f2a5a" : "transparent"
                        border.color: root.currentPage === modelData ? root.accent : "transparent"; border.width: 1
                        Text { anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; anchors.leftMargin: 12; text: modelData; color: root.currentPage === modelData ? "white" : "#c5c5d6"; font.pixelSize: 13 }
                        MouseArea { anchors.fill: parent; onClicked: root.currentPage = modelData }
                    }
                }
                Item { Layout.fillHeight: true }
                Text { text: "CPU " + Telemetry.cpuTemp + "°  GPU " + Telemetry.gpuTemp + "°  LIQ " + Telemetry.liquidTemp + "°"; color: "#6c5cff"; font.pixelSize: 12 }
            }
        }
        Rectangle {
            Layout.fillWidth: true; Layout.fillHeight: true; color: root.bg
            Loader {
                anchors.fill: parent; anchors.margins: 24
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
