import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ColumnLayout {
    id: columnLayout

    Rectangle {
        Layout.fillWidth: true
        implicitHeight: 40
        TabBar {
            id: tabBar
            anchors.fill: parent
            TabButton {
                text: qsTr("3 Fold")
                onClicked: swipeView.currentIndex = 0
            }

            TabButton {
                text: qsTr("5 Fold")
                onClicked: swipeView.currentIndex = 1
            }
            TabButton {
                text: qsTr("7 Fold")
                onClicked: console.log('7 fold clicked')
            }
            TabButton {
                text: qsTr("9 Fold")
                onClicked: console.log('9 fold clicked')
            }
        }
    }

    SwipeView {
        id: swipeView
        width: 200
        height: 200
        Layout.fillHeight: true
        Layout.fillWidth: true
        onCurrentIndexChanged: tabBar.currentIndex = currentIndex

        Page {
            id: firstPage
            RfResultPage {
                anchors.fill: parent
            }
        }

        Page {
            id: secondPage
            Text {
                text: qsTr("T 2")
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
