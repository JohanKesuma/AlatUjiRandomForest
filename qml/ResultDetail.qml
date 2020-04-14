import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

ColumnLayout {
    ToolBar {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("‹")
                onClicked: stack.pop()
            }
            Label {
                text: "Detail Klasifikasi"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                elide: Label.ElideRight
                Layout.fillWidth: true
            }
        }
    }

    Rectangle {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.fillWidth: true
        Layout.fillHeight: true

        Component.onCompleted: {
            console.log(applicationPath)
        }

        Image {
            id: treeImg
            anchors.fill: parent
            source: applicationPath + "tree.png"
        }
    }
}
