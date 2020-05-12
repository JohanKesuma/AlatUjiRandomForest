import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ColumnLayout {
    property variant akurasi
    property variant attr
    property variant rfList
    property variant jumlahPohon
    ToolBar {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        RowLayout {
            ToolButton {
                text: qsTr("‹")
                onClicked: stack.pop()
            }

            Label {
                id: title
                text: qsTr("Hasil")
                font.pointSize: 12
            }
        }
    }

    Text {
        text: 'Akurasi : ' + akurasi
        Layout.bottomMargin: 5
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        font.pointSize: 20
    }

    Rectangle {
        id: rectangle1
        Layout.fillWidth: true
        implicitHeight: 30

        TabBar {
            id: tabBar
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width

            background: Rectangle {
                color: "#eeeeee"
            }

            TabButton {
                id: bbuButton
                text: qsTr("Pohon")
                implicitWidth: 100
                onClicked: resultSwipeView.setCurrentIndex(0)
            }
            TabButton {
                id: pbuButton
                text: qsTr("Prediksi")
                implicitWidth: 100
                onClicked: resultSwipeView.setCurrentIndex(1)
            }
        }


    }

    SwipeView {
        id: resultSwipeView
        Layout.fillHeight: true
        Layout.fillWidth: true
        onCurrentIndexChanged: tabBar.setCurrentIndex(currentIndex)
        Page {
            TampilPohon{
                anchors.fill: parent
            }
        }
        Page {
            Prediksi {
                anchors.fill: parent
            }
        }
    }
}
