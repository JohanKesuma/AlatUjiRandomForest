import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import RFModel 1.0

ColumnLayout {
    property variant attrList: attr
    property variant attrInput: []
    property variant attrLabel: []
    Rectangle {
        Layout.fillHeight: true
        Layout.fillWidth: true

        RowLayout {
            anchors.centerIn: parent
            Frame {
                Layout.fillHeight: true
                ColumnLayout {
                    GridLayout {
                        id: gridLayout
                        columnSpacing: 20
                        rowSpacing: 5
                        columns: 2
                        Component.onCompleted: {
                            console.log('atibut = '  +attrList +', '+ attr.length);
                            
                            for (let i = 0; i < attrList.length; i++)  {
                                const label = Qt.createComponent('AttrLabel.qml')
                                const labelObject = label.createObject(gridLayout, {"labelText": attrList[i]})
                                const inputField = Qt.createComponent('AttrInput.qml')
                                const inptFieldObject = inputField.createObject(gridLayout)
                                attrInput[i] = inptFieldObject
                                attrLabel[i] = labelObject
                            }
                        }
                        
                    }

                    Button {
                        text: 'Prediksi'
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        onClicked: {
                            let attrValues = []
                            let attrLabels = []
                            for (let i = 0; i < attrList.length; i++)  {
                                attrValues[i] = parseFloat(attrInput[i].text)
                                if (isNaN(attrValues[i])) {
                                    errorLabel.visible = true
                                    return;
                                }

                                attrLabels[i] = attrLabel[i].text
                            }
                            attrValues = [attrValues]
                            errorLabel.visible = false

                            const model = RootDialog.onPrediksiButton(rfList, attrLabels, attrValues)
                                
                            hasilPrediksiFrame.visible = true
                            hasilPrediksiListView.model = model
                                
                        }
                    }
                    Label {
                        id: errorLabel
                        visible: false
                        color: "#ff0000"
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        text: 'Input harus berupa angka dan tidak boleh kosong'
                    }
                }
                
            }

            Frame {
                id: hasilPrediksiFrame
                visible: false
                Layout.fillHeight: true
                implicitWidth: 200

                ColumnLayout {
                    anchors.fill: parent
                    Text {
                        text: qsTr("Hasil Prediksi")
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                    }

                    ToolSeparator {
                        orientation: Qt.Horizontal
                        width: parent.width
                        Layout.fillWidth: true
                        bottomPadding: 5
                        rightPadding: 3
                        leftPadding: 3
                        topPadding: 5
                    }

                    ListView {
                        id: hasilPrediksiListView
                        clip: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        delegate: Rectangle {
                            implicitHeight: 30
                            implicitWidth: 200
                            RowLayout {
                                spacing: 15
                                Label {
                                    text: model.name
                                }
                                Text {
                                    text: model.prediksiStr
                                }
                            }
                        }
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
