import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


Rectangle {

    id: rectangle
    anchors.fill: parent

    Button {
        id: openDatasetButton
        flat: true
        y: 17
        width: 120
        height: 50
        text: qsTr("Open Dataset")
        display: AbstractButton.TextOnly
        anchors.left: parent.left
        anchors.leftMargin: 40
        onClicked: MainWindow.openDataset()
    }

    Label {
        id: recentDatasetLabel
        text: qsTr("Recent Dataset")
        anchors.top: openDatasetButton.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 40
        fontSizeMode: Text.FixedSize
        renderType: Text.QtRendering
    }

    ListView {
        id: listView
        boundsBehavior: Flickable.StopAtBounds
        visible: true
        clip: false
        anchors.top: recentDatasetLabel.bottom
        anchors.topMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 40
        implicitWidth: 200
        implicitHeight: 50
        spacing: 10
        model: ListModel {
            ListElement {
                name: "Johan"
                description: "Mahasiswa"
            }
            ListElement {
                name: "Satria"
                description: "Mahasiswa"
            }
        }
//        delegate: Loader {
//            source: "recentFileList.qml";
//        }
        delegate: RecentFileList {
            id: recent
        }

    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
