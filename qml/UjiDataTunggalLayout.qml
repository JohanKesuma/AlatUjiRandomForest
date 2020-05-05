import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ColumnLayout {
    property variant attrList: []
    property variant attrInput: []
    property variant rfList
    ToolBar {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        RowLayout {
            ToolButton {
                text: qsTr("‹")
                onClicked: stack.pop()
            }
            Label {
                text: "Uji Data Tunggal"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                elide: Label.ElideRight
            }
        }
    }

    Rectangle {
        Layout.fillHeight: true
        Layout.fillWidth: true

        Frame {
            anchors.centerIn: parent
            ColumnLayout {
                GridLayout {
                    id: gridLayout
                    columnSpacing: 20
                    rowSpacing: 5
                    columns: 2
                    Component.onCompleted: {
                        for (let i = 0; i < attrList.length; i++)  {
                            const label = Qt.createComponent('AttrLabel.qml')
                            label.createObject(gridLayout, {"labelText": attrList[i]})
                            const inputField = Qt.createComponent('AttrInput.qml')
                            const inptFieldObject = inputField.createObject(gridLayout)
                            attrInput[i] = inptFieldObject
                        }
                    }
                    
                }

                Button {
                        text: 'Prediksi'
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        onClicked: {
                            let attrValues = []
                            for (let i = 0; i < attrList.length; i++)  {
                                attrValues[i] = parseFloat(attrInput[i].text)
                            }
                            attrValues = [attrValues]
                            

                            RootDialog.onPrediksiButton(rfList, attrValues)
                        }
                    }
            }
            
        }



    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
