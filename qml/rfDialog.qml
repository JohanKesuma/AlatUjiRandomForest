import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import RFModel 1.0

Item {
    id: element
    NumberAnimation on opacity {
        from: 0
        to: 1
        duration: 200
        running: true
    }

    StackView {
        id: stack
        initialItem: main
        anchors.fill: parent
    }

    Component {
        id: result
        RFOneResult {

        }
    }

    Component {
        id: main
        Rectangle {
            anchors.fill: parent
            ColumnLayout {
                anchors.centerIn: parent
                GridLayout {

                    columnSpacing: 30
                    columns: 2
                    Label {
                        id: crossValidationLabel
                        text: qsTr("Cross Validation")
                    }

                    TextField {
                        id: crossValidationTextField
                        validator: IntValidator{
                            bottom: 2
                            top: 99
                        }
                    }

                    Label {
                        id: jumlahPohonLabel
                        text: qsTr("Jumlah Pohon")
                    }

                    TextField {
                        id: jumlahPohonTextField
                        validator: IntValidator{
                            bottom: 1
                            top: 100000
                        }
                    }

                    Label {
                        text: 'Bootstrap'
                    }

                    CheckBox {
                        id: bootstrapCheckBox
                        checked: true
                    }

                    Label {
                        text: qsTr('Max Features')
                    }

                    ComboBox {
                        id: maxFeaturesComboBox
                        textRole: 'text'
                        model: ListModel {
                            ListElement {
                                text: 'sqrt'
                                value: 'sqrt'
                            }
                            ListElement {
                                text: 'log2'
                                value: 'log2'
                            }
                            ListElement {
                                text: 'Semua'
                                value: null
                            }
                            ListElement {
                                text: 'Input'
                                value: 0
                            }
                        }
                        onCurrentIndexChanged: {
                            let currentElemen = maxFeaturesComboBox.model.get(currentIndex)
                            console.log(currentElemen.value)
                            if (currentElemen.value === '0' ) {
                                nFeatuersLabel.visible = true
                                nFeaturesComboBox.visible = true
                            } else {
                                nFeatuersLabel.visible = false
                                nFeaturesComboBox.visible = false
                            }
                        }

                    }

                    Label {
                        id: nFeatuersLabel
                        text: qsTr('N Features')
                        visible: false
                    }

                    ComboBox {
                        id: nFeaturesComboBox
                        textRole: 'text'
                        visible: false
                        model: ListModel {

                        }
                    }

                    Label {
                        text: 'Kelas'
                    }

                    ComboBox {
                        id: kelasComboBox
                        textRole: 'kelas'
                        model: RootDialog.kelasModel
                        onCurrentIndexChanged: {
                            const nFeaturesComboBoxIndex = nFeaturesComboBox.currentIndex;
                            let idx = 0;

                            console.log('kelas current index ' + kelasComboBox.currentIndex);
                            console.log('model ' + kelasComboBox.model.get(kelasComboBox.currentIndex, 'attr'));

                            const attrLength = kelasComboBox.model.get(kelasComboBox.currentIndex, 'attr').length;

                            nFeaturesComboBox.model.clear()

                            for (let i=1; i<=attrLength;i++) {
                                nFeaturesComboBox.model.append({text: i, value: i})
                            }

                            if (nFeaturesComboBoxIndex > attrLength - 1) {
                                nFeaturesComboBox.currentIndex = attrLength - 1;
                            } else if(nFeaturesComboBoxIndex < 0) {
                                nFeaturesComboBox.currentIndex = 0;
                            } else {
                                nFeaturesComboBox.currentIndex = nFeaturesComboBoxIndex;
                            }
                        }
                    }
                }

                Button {
                    text: 'Proses'
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    onClicked: {
                        const jumlah_pohon = parseInt(jumlahPohonTextField.text);
                        const n_validation = parseInt(crossValidationTextField.text);
                        errorLabel.text = '';
                        if (isNaN(jumlah_pohon) || isNaN(n_validation)) {
                            errorLabel.text = 'Input harus berupa angka dan tidak boleh kosong'
                            errorLabel.visible = true;
                            return;
                        }

                        if (n_validation < 2) {
                            errorLabel.text = errorLabel.text + '\nCross Validation harus >= 2'
                            errorLabel.visible = true;
                            return;
                        }
                        let maxFeatures = maxFeaturesComboBox.model.get(maxFeaturesComboBox.currentIndex).value
                        if (maxFeatures === '0') {
                            maxFeatures = parseInt(nFeaturesComboBox.model.get(nFeaturesComboBox.currentIndex).value)
                            if (isNaN(maxFeatures)) {
                                errorLabel.visible = true;
                                return;
                            }
                        }

                        errorLabel.visible = false;
                        
                        console.log('max feature : ' + maxFeatures);
                        
                        const data = RootDialog.onProsesButton(kelasComboBox.currentIndex, jumlah_pohon, n_validation, bootstrapCheckBox.checked, maxFeatures);
                        let akurasi
                        let attr
                        let rfList
                        for(let key in data){
                            if (key === 'akurasi') {
                                akurasi = data[key]
                            } else if(key === 'attr') {
                                attr = data[key]
                                console.log('attr ' + data[key].length);
                                
                            } else if (key === 'classifiers') {
                                rfList = data[key]
                            }
                        }
                        
                        stack.push(result, {akurasi: akurasi, attr: attr, rfList: rfList, jumlahPohon: jumlah_pohon})
                    }
                }

                Label {
                    id: errorLabel
                    visible: false
                    color: "#ff0000"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
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
