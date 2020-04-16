import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtCharts 2.3

import RFModel 1.0

RowLayout {
    Rectangle {
        id: rectangle
        Layout.fillHeight: true
        Layout.fillWidth: true
        ListView {

            id: resultListView
            height: parent.height
            anchors.centerIn: parent
            implicitWidth: 200
            model: resultModel

            delegate: Rectangle {
                implicitHeight: 50
                width: parent.width
                RowLayout {
                    width: parent.width
                    ColumnLayout {
                        Text {
                            text: model.jumlahPohon
                        }
                        Text {
                            text: model.akurasi
                        }
                    }

                    Button {
                        text: 'Detail'
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        font.capitalization: Font.MixedCase
                        flat: true
                        onClicked: {
                            stack.push(resultDetail, {estimators: model.estimators, attr: model.attr})
                        }
                    }
                }
                

                ToolSeparator {
                    orientation: Qt.Horizontal
                    width: parent.width
                    leftPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                }

            }
        }
    }

    Rectangle {
        Layout.fillHeight: true
        Layout.fillWidth: true

        ChartView {
            title: "Hasil Akurasi"
            anchors.fill: parent
            legend.visible: false
            antialiasing: true

            BarSeries {
                id: mySeries
                property var xValues: ["2007", "2008", "2009", "2010", "2011", "2012" ]

                Component.onCompleted: {
                    
                    var xValues = []
                    var i = 0
                    var data = resultModel.model
                    data.forEach(element => {
                        xValues[i] = element.akurasi
                        i++
                        console.log("akurasi ", element.akurasi)
                        
                    });
                    console.log("xValues :", xValues);
                    
                    barSet.values = xValues

                }

                axisX: BarCategoryAxis {
                    titleText: "Jumlah Pohon"
                    categories: swipeView.nPohon
                }
                axisY: ValueAxis {
                    id: axisY
                    min: 0
                    max: 1
                    tickCount: 1
                    titleText: "Akurasi"
                }

                BarSet {
                    id: barSet
                    values: [2, 2, 3, 4, 5, 6] 
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
