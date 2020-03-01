import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    id: element
    NumberAnimation on opacity {
        from: 0
        to: 1
        duration: 200
        running: true
    }

    GridLayout {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20

        columnSpacing: 30
        columns: 2
        Label {
            id: jumlahPohonLabel
            text: qsTr("Jumlah Pohon")
        }

        TextField {
            id: jumlahPohonTextField
            placeholderText: qsTr("Masukkan Jumlah Pohon")
        }

        Label {
            id: crossValidationLabel
            text: qsTr("Cross Validation")
        }

        TextField {
            id: crossValidationTextField
            placeholderText: qsTr("N Cross Validation")
        }
    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 15

        spacing: 10
        Button {
            id: closeButton
            text: qsTr("Close")
            onClicked: RootDialog.close()
        }

        Button {
            id: okButton
            text: qsTr("OK")
            onClicked: RootDialog.onOkButton(parseInt(jumlahPohonTextField.text), parseInt(crossValidationTextField.text))
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
