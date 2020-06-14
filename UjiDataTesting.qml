import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle {
    ColumnLayout {
        anchors.centerIn: parent
        Button {
            text: 'Open Data Testing'
        }
        Frame {
            id: frame
            Layout.fillHeight: true
            Layout.fillWidth: true
            ColumnLayout {
                anchors.verticalCenterOffset: 0
                anchors.horizontalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    text: "Akurasi :"
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                }
                Label {
                    text: '0'
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    font.pointSize: 34
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
