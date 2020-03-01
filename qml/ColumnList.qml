import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import RFModel 1.0
ColumnLayout {
    anchors.fill: parent

    Text {
        id: columnHeader
        text: qsTr("Kolom")
        font.bold: true
        font.pointSize: 20
        Layout.leftMargin: 10

    }

    ListView {
        id: listView
        Layout.fillHeight: true
        Layout.fillWidth: true

        Connections {
            target: MainWindow
            onColumnModelInited: {
                listView.model = columnModel
            }
        }
        delegate: Rectangle {
            id: rectangle
            implicitHeight: 50
            width: parent.width
            RowLayout {
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10

                Text {
                    text: model.name
                }
                RowLayout {
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    CheckBox {
                        text: qsTr("Target")
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.fillWidth: false
                        checked: model.isTarget
                    }
                    RoundButton {
                        display: AbstractButton.IconOnly
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        flat: true
                        Image {
                            anchors.centerIn: parent
                            id: buttonImage
                            width: 22
                            height: 22
                            source: "../images/trash.png"
                        }

                    }
                }


            }
            ToolSeparator {
                orientation: Qt.Horizontal
                width: listView.width
                bottomPadding: 0
                topPadding: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
            }
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
