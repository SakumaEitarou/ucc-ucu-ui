
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    visible: true
    width: 1280
    height: 800
    color: "#111115"
    title: "UCC - XMG Neo A25"

    property string currentPage: "Dashboard"
    property color accent: "#6c5cff"
    property color bg: "#1a1a1f"
    property color card: "#24242e"
    property color cardHover: "#2d2d3a"

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Sidebar - UCU style NavigationView
        Rectangle {
            Layout.preferredWidth: 260
            Layout.fillHeight: true
            color: "#1e1e28"
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 4
                // Header
                RowLayout {
                    Layout.fillWidth: true
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
                    model: [
                        {name: "Dashboard", icon: "◈"},
                        {name: "Presets", icon: "⚡"},
                        {name: "Fan Control", icon: "❄"},
                        {name: "Hydro UI", icon: "💧"},
                        {name: "Keyboard", icon: "⌨"},
                        {name: "Light Bar", icon: "—"},
                        {name: "Battery", icon: "🔋"},
                        {name: "Display", icon: "◫"}
                    ]
                    delegate: Rectangle {
                        Layout.fillWidth: true
                        height: 44
                        radius: 10
                        color: root.currentPage === modelData.name ? "#2f2a5a" : "transparent"
                        border.color: root.currentPage === modelData.name ? root.accent : "transparent"
                        border.width: 1
                        Row {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                            spacing: 12
                            Text { text: modelData.icon; color: root.currentPage === modelData.name ? root.accent : "#9a9ab0"; font.pixelSize: 14 }
                            Text { text: modelData.name; color: root.currentPage === modelData.name ? "white" : "#c5c5d6"; font.pixelSize: 13; font.bold: root.currentPage === modelData.name }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: root.currentPage = modelData.name
                            hoverEnabled: true
                            onEntered: if(root.currentPage !== modelData.name) parent.color = root.cardHover
                            onExited: if(root.currentPage !== modelData.name) parent.color = "transparent"
                        }
                    }
                }
                Item { Layout.fillHeight: true }
                Rectangle { Layout.fillWidth: true; height: 1; color: "#2a2a35" }
                // Settings / About
                Repeater {
                    model: ["Settings", "About"]
                    delegate: Rectangle {
                        Layout.fillWidth: true; height: 40; radius: 8; color: "transparent"
                        Text { anchors.centerIn: parent; text: modelData; color: "#888" }
                        MouseArea { anchors.fill: parent; onClicked: root.currentPage = modelData }
                    }
                }
            }
        }

        // Main Content
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: root.bg
            Loader {
                anchors.fill: parent
                anchors.margins: 24
                source: {
                    switch(root.currentPage) {
                        case "Dashboard": return "pages/Dashboard.qml"
                        case "Presets": return "pages/Presets.qml"
                        case "Fan Control": return "pages/FanControl.qml"
                        case "Hydro UI": return "pages/Hydro.qml"
                        default: return "pages/Dashboard.qml"
                    }
                }
            }
        }
    }
}
