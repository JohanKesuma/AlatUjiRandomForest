import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Rectangle {
    property variant dataTesting: null
            anchors.fill: parent
            ColumnLayout {
                anchors.centerIn: parent
                GridLayout {

                    columnSpacing: 30
                    columns: 2

                    Label {
                        text: 'Data Testing'
                    }
                    
                    RowLayout {
                        Button {
                            text: 'Browse'
                            onClicked: {
                                const file = RootDialog.openDataset()
                                if(file === null)
                                    return;

                                const dataTestingFileName = file[1]
                                dataTesting = file[0]
                                console.log(dataTestingFileName);
                                fileNameLabel.text = dataTestingFileName
                                fileNameLabel.visible = true
                            }
                        }

                        Label {
                            id: fileNameLabel
                            visible: false
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
                        errorLabel.text = '';
                        if (isNaN(jumlah_pohon) || dataTesting === null) {
                            errorLabel.text = 'Input harus berupa angka dan tidak boleh kosong'
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
                        
                        const data = RootDialog.onProsesTrainingTesting(dataTesting, kelasComboBox.currentIndex, jumlah_pohon, bootstrapCheckBox.checked, maxFeatures);
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
