import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Rectangle {
    property variant dataTesting: null
    property variant dataModel
            anchors.fill: parent
            ColumnLayout {
                anchors.centerIn: parent
                GridLayout {

                    columnSpacing: 30
                    columns: 2

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

                            const kelas = kelasComboBox.model.get(kelasComboBox.currentIndex, 'kelas')
                            dataModel = RootDialog.loadOptimalModel(kelas);

                            for(let key in dataModel){
                                if (key === 'jumlah_pohon') {
                                    jumlahPohonTextField.text = dataModel[key]
                                } else if(key === 'bootstrap') {
                                    bootstrapCheckBox.checked = dataModel[key]
                                } else if (key === 'max_features') {
                                    if (typeof(dataModel[key]) === 'undefined') {
                                        maxFeaturesTextField.text = 'Semua';
                                    } else {
                                        maxFeaturesTextField.text = dataModel[key]
                                    }
                                    
                                }
                            }
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
                        enabled: false
                    }

                    Label {
                        text: 'Bootstrap'
                    }

                    CheckBox {
                        id: bootstrapCheckBox
                        enabled: false
                    }

                    Label {
                        text: qsTr('Max Features')
                    }

                    TextField {
                        id: maxFeaturesTextField
                        enabled: false
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

                }

                Button {
                    text: 'Load'
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    onClicked: {
                        const jumlah_pohon = parseInt(jumlahPohonTextField.text);
                        errorLabel.text = '';
                        if (isNaN(jumlah_pohon)) {
                            errorLabel.text = 'Input harus berupa angka dan tidak boleh kosong'
                            errorLabel.visible = true;
                            return;
                        }
                        // let maxFeatures = maxFeaturesComboBox.model.get(maxFeaturesComboBox.currentIndex).value
                        // if (maxFeatures === '0') {
                        //     maxFeatures = parseInt(nFeaturesComboBox.model.get(nFeaturesComboBox.currentIndex).value)
                        //     if (isNaN(maxFeatures)) {
                        //         errorLabel.visible = true;
                        //         return;
                        //     }
                        // }

                        errorLabel.visible = false;
                        
                        // const data = RootDialog.onProsesTrainingTesting(dataTesting, kelasComboBox.currentIndex, jumlah_pohon, bootstrapCheckBox.checked, maxFeatures);
                        let akurasi
                        let attr
                        let rfList
                        for(let key in dataModel){
                            if (key === 'akurasi') {
                                akurasi = dataModel[key]
                            } else if(key === 'attr') {
                                attr = dataModel[key]
                                console.log('attr ' + dataModel[key].length);
                                
                            } else if (key === 'classifiers') {
                                rfList = dataModel[key]
                            }
                        }
                        
                        stack.push(result, {akurasi: akurasi, attr: attr, rfList: rfList, jumlahPohon: jumlah_pohon, kelas: kelasComboBox.model.get(kelasComboBox.currentIndex, 'kelas')})
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
