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

    Flickable {
        anchors.fill: parent
        anchors.margins: 16
        contentHeight: col.implicitHeight
        clip: false
        ColumnLayout {
            id: col
            width: parent.width
            spacing: 14
            Text { text: "Performance Presets"; color: textMain; font.pixelSize: 22; font.bold: true }
            Text { text: "TDP • Fan • Power profiles for XMG Neo A25"; color: textSub; font.pixelSize: 11 }

            GridLayout { columns: 2; columnSpacing: 12; rowSpacing: 12; Layout.fillWidth: true
                Repeater { model: [
                    {name:"Silent", tdp:"45W", fan:"25%", power:"120W", desc:"22 dB • Library / Office", color:"#2a2a3a"},
                    {name:"Balanced", tdp:"95W", fan:"47%", power:"160W", desc:"28 dB • Daily • Active", color:"#2a224a", active:true},
                    {name:"Performance", tdp:"150W", fan:"72%", power:"220W", desc:"38 dB • Gaming / Creator", color:"#2a2a3a"},
                    {name:"Turbo", tdp:"170W", fan:"100%", power:"280W", desc:"45 dB • Max OC • OASIS", color:"#3a1a1a"}
                ]
                    Rectangle {
                        Layout.fillWidth: true; Layout.preferredHeight: 140; color: modelData.active ? "#2a224a" : card; radius: 16; border.color: modelData.active ? accent : cardBorder; border.width: modelData.active ? 1.5 : 1
                        ColumnLayout { anchors.fill: parent; anchors.margins: 16; spacing: 8
                            RowLayout { Text { text: modelData.name; color: textMain; font.bold: true; font.pixelSize: 16 } Item { Layout.fillWidth: true } Rectangle { width: 60; height: 20; radius: 10; color: modelData.active?accent:"#252530"; Text { anchors.centerIn: parent; text: modelData.active?"Active":"Select"; color: modelData.active?"white":textSub; font.pixelSize: 10; font.bold: modelData.active } } }
                            Text { text: modelData.desc; color: textSub; font.pixelSize: 11 }
                            RowLayout { spacing: 12
                                ColumnLayout { Text { text: "TDP"; color: textSub; font.pixelSize: 8 } Text { text: modelData.tdp; color: textMain; font.bold: true; font.pixelSize: 13 } }
                                ColumnLayout { Text { text: "FAN"; color: textSub; font.pixelSize: 8 } Text { text: modelData.fan; color: textMain; font.bold: true; font.pixelSize: 13 } }
                                ColumnLayout { Text { text: "POWER"; color: textSub; font.pixelSize: 8 } Text { text: modelData.power; color: textMain; font.bold: true; font.pixelSize: 13 } }
                                Item { Layout.fillWidth: true }
                                Text { text: "⚡"; font.pixelSize: 20 }
                            }
                        }
                    }
                }
            }
        }
    }
}
