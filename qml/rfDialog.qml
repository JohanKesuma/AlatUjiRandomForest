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
                        id: jumlahPohonLabel
                        text: qsTr("Jumlah Pohon")
                    }

                    TextField {
                        id: jumlahPohonTextField
                        placeholderText: qsTr("Masukkan Jumlah Pohon")
                        validator: IntValidator{
                            bottom: 1
                            top: 100000
                        }
                    }

                    Label {
                        id: crossValidationLabel
                        text: qsTr("Cross Validation")
                    }

                    TextField {
                        id: crossValidationTextField
                        placeholderText: qsTr("N Cross Validation")
                        validator: IntValidator{
                            bottom: 1
                            top: 99
                        }
                    }

                    Label {
                        text: 'Kelas'
                    }

                    ComboBox {
                        id: kelasComboBox
                        textRole: 'kelas'
                        model: RootDialog.kelasModel
                    }
                }

                Button {
                    text: 'Proses'
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    onClicked: {
                        const jumlah_pohon = parseInt(jumlahPohonTextField.text);
                        const n_validation = parseInt(crossValidationTextField.text);
                        if (isNaN(jumlah_pohon) || isNaN(n_validation)) {
                            errorLabel.visible = true;
                            return;
                        }
                        errorLabel.visible = false;
                        console.log(JSON.stringify(kelasComboBox.model.data));
                        const data = RootDialog.onProsesButton(kelasComboBox.currentIndex, jumlah_pohon, n_validation);
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
                    text: 'Input harus berupa angka dan tidak boleh kosong'
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
