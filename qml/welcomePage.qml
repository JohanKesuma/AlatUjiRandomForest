import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


Rectangle {

    id: rectangle

    NumberAnimation on opacity {
        from: 0
        to: 1
        duration: 200
        running: true
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        Text {
            text: 'Klasifikasi Status Gizi Balita\n Menggunakan Metode Random Forest'
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 22
            Layout.fillWidth: true
        }

        Button {
            id: openDatasetButton
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: qsTr("Open Dataset")
            display: AbstractButton.TextOnly
            onClicked: MainWindow.openDataset()
        }   
    }

    Popup {
        id: popup
        x: openDatasetButton.mapToGlobal(0,0).x
        y: openDatasetButton.mapToGlobal(0,0).y
        width: 200
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        Rectangle {
            anchors.fill: parent
            Text {
                id: name
                text: qsTr("Name")
                anchors.centerIn: parent
            }

        }
    }
}




/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
