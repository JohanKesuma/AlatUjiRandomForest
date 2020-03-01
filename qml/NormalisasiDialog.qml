import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
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
        columnSpacing: 20
        flow: GridLayout.TopToBottom
        rows: 2
        columns: 2
        anchors.centerIn: parent

        Label {
            id: minLabel
            text: qsTr("Min")
        }

        Label {
            id: maxLabel
            text: qsTr("Max")
        }

        TextField {
            id: minTextField
            placeholderText: qsTr("Masukkan Min")
            validator: IntValidator{
                bottom: 0
                top: 100
            }
        }

        TextField {
            id: maxTextField
            placeholderText: qsTr("Masukkan Max")
            validator: IntValidator{
                bottom: 0
                top: 100
            }
        }

    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 15

        Button {
            id: cancelButton
            text: qsTr("Cancel")
            Material.background: Material.Red
            onClicked: DialogRoot.close()
        }

        Button {
            id: okButton
            text: qsTr("OK")
            Material.background: Material.Blue
            onClicked: DialogRoot.onOkButton(parseInt(minTextField.text), parseInt(maxTextField.text))
        }
    }



    Text {
        id: headerText
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Normalisasi Min Max")
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenterOffset: 0
        font.bold: true
        font.pixelSize: 30
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
