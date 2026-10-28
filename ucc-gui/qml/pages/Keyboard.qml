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

    property string currentColor: "#6c5cff"
    property int brightness: 80
    property string currentMode: "Wave"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16

        // Header
        RowLayout {
            Layout.fillWidth: true
            ColumnLayout { spacing: 2
                Text { text: "Light Bar & Keyboard"; color: textMain; font.pixelSize: 24; font.bold: true }
                Text { text: "Per-key RGB + 28 zone light bar • XMG NEO A25"; color: textSub; font.pixelSize: 12 }
            }
            Item { Layout.fillWidth: true }
            Rectangle { width: 120; height: 32; radius: 16; color: accent
                Text { anchors.centerIn: parent; text: "Per-key RGB"; color: "white"; font.pixelSize: 12; font.bold: true }
            }
        }

        GridLayout {
            columns: 2
            columnSpacing: 16
            rowSpacing: 16
            Layout.fillWidth: true
            Layout.fillHeight: true

            // Left - Keyboard + Light bar preview - FIXED OVERLAP
            Rectangle {
                Layout.fillWidth: true; Layout.fillHeight: true; color: card; radius: 20; border.color: cardBorder; border.width: 1
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 20; spacing: 20

                    // Keyboard mock - centered, not overlapping header
                    Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 200; color: "#0f0f13"; radius: 16; border.color: "#1e1e2a"; border.width: 1
                        ColumnLayout { anchors.centerIn: parent; spacing: 8
                            // 4 rows of keys
                            Repeater { model: 4
                                RowLayout { Layout.alignment: Qt.AlignHCenter; spacing: 6
                                    Repeater { model: 10
                                        Rectangle { width: 32; height: 32; radius: 8; color: currentColor; opacity: 0.7
                                            Rectangle { anchors.fill: parent; radius: 8; color: "transparent"; border.color: currentColor; border.width: 1; opacity: 0.3 }
                                        }
                                    }
                                }
                            }
                            // Light bar
                            Rectangle { Layout.alignment: Qt.AlignHCenter; width: 360; height: 12; radius: 6; color: "#15151d"
                                RowLayout { anchors.fill: parent; anchors.margins: 2; spacing: 2
                                    Repeater { model: 28
                                        Rectangle { Layout.fillWidth: true; Layout.fillHeight: true; radius: 2; color: currentColor; opacity: 0.9 }
                                    }
                                }
                            }
                        }
                    }

                    ColumnLayout { spacing: 10; Layout.fillWidth: true
                        Text { text: "Light Bar - 28 zones • Preview"; color: textSub; font.pixelSize: 11 }
                        Rectangle { Layout.fillWidth: true; height: 40; radius: 10; color: "#15151d"
                            RowLayout { anchors.fill: parent; anchors.margins: 4; spacing: 2
                                Repeater { model: 28
                                    Rectangle { Layout.fillWidth: true; Layout.fillHeight: true; radius: 3; color: currentColor
                                        MouseArea { anchors.fill: parent; onClicked: root.currentColor = parent.color }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Right - Controls
            ColumnLayout {
                Layout.preferredWidth: 400
                spacing: 16

                Rectangle { Layout.fillWidth: true; height: 160; color: card; radius: 20; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 20; spacing: 14
                        RowLayout { Text { text: "Color"; color: textSub; font.pixelSize: 13 } Item { Layout.fillWidth: true } Text { text: currentColor; color: accent; font.pixelSize: 12 } }
                        GridLayout { columns: 7; columnSpacing: 12; rowSpacing: 12
                            Repeater { model: ["#6c5cff","#4ecdc4","#ff6b9d","#3dd598","#ffb347","#ffffff","#ff4444","#44aaff","#aaff44","#ffaa44","#aa44ff","#44ffaa","#ff44aa","#000000"]
                                Rectangle { width: 36; height: 36; radius: 18; color: modelData; border.color: root.currentColor===modelData ? "white" : cardBorder; border.width: root.currentColor===modelData ? 3 : 1
                                    MouseArea { anchors.fill: parent; onClicked: root.currentColor = modelData }
                                }
                            }
                        }
                    }
                }

                Rectangle { Layout.fillWidth: true; height: 90; color: card; radius: 20; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 20; spacing: 12
                        RowLayout { Text { text: "Keyboard Brightness"; color: textSub; font.pixelSize: 13 } Item { Layout.fillWidth: true } Rectangle { width: 44; height: 22; radius: 6; color: "#252530"; Text { anchors.centerIn: parent; text: brightness + "%"; color: textMain; font.pixelSize: 12 } } }
                        Rectangle { Layout.fillWidth: true; height: 6; radius: 3; color: "#2a2a3a"
                            Rectangle { width: parent.width * (brightness/100); height: parent.height; radius: 3; color: accent }
                            Rectangle { x: parent.width * (brightness/100) - 8; y: -5; width: 16; height: 16; radius: 8; color: "white" }
                        }
                    }
                }

                Rectangle { Layout.fillWidth: true; height: 160; color: card; radius: 20; border.color: cardBorder; border.width: 1
                    ColumnLayout { anchors.fill: parent; anchors.margins: 20; spacing: 12
                        Text { text: "Effects"; color: textSub; font.pixelSize: 13 }
                        GridLayout { columns: 2; columnSpacing: 8; rowSpacing: 8
                            Repeater { model: ["Static","Wave","Breathing","Rainbow","Reactive","Cycle"]
                                Rectangle { width: 160; height: 36; radius: 10; color: modelData===root.currentMode ? accent : "#252530"
                                    Text { anchors.centerIn: parent; text: modelData; color: modelData===root.currentMode ? "white" : textSub; font.pixelSize: 12; font.bold: modelData===root.currentMode }
                                    MouseArea { anchors.fill: parent; onClicked: root.currentMode = modelData }
                                }
                            }
                        }
                    }
                }

                Rectangle { Layout.fillWidth: true; height: 80; color: card; radius: 20; border.color: accent; border.width: 1.5
                    RowLayout { anchors.fill: parent; anchors.margins: 16; spacing: 12
                        Rectangle { width: 40; height: 40; radius: 10; color: "#2a1e4a"
                            Text { anchors.centerIn: parent; text: "💧"; font.pixelSize: 20 }
                        }
                        ColumnLayout { spacing: 2
                            Text { text: "Sync with OASIS"; color: textMain; font.pixelSize: 13; font.bold: true }
                            Text { text: "Match cooling loop " + currentColor; color: textSub; font.pixelSize: 11 }
                        }
                        Item { Layout.fillWidth: true }
                        Rectangle { width: 44; height: 26; radius: 13; color: accent
                            Rectangle { x: 20; y: 3; width: 20; height: 20; radius: 10; color: "white" }
                        }
                    }
                }

                Item { Layout.fillHeight: true }
            }
        }
    }
}
