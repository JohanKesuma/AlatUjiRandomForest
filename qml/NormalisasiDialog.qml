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

    ColumnLayout {
        anchors.centerIn: parent
        GridLayout {
            columnSpacing: 20
            flow: GridLayout.TopToBottom
            rows: 2
            columns: 2

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

        Label {
            id: errorLabel
            visible: false
            color: "red"
            text: 'Input tidak valid.'
        }
    }
    

    RowLayout {
        id: rowLayout
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
            onClicked: {
                const min = parseInt(minTextField.text);
                const max = parseInt(maxTextField.text);
                if (rowLayout.checkInput(min, max)) {
                    errorLabel.visible = false
                    DialogRoot.onOkButton(min, max);
                    return;
                }
                errorLabel.visible = true;
            }
        }

        function checkInput(min, max) {
            if(isNaN(min) || isNaN(max)) {
                return false;
            }

            if (min > max || min === max) {
                return false;
            }

            return true
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
