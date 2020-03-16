import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import RFModel 1.0

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
                onClicked: swipeView.currentIndex = 2
            }
            TabButton {
                text: qsTr("9 Fold")
                onClicked: swipeView.currentIndex = 3
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
        property variant resultModels: RootDialog.resultModels()

        Page {
            id: firstPage
            RfResultPage {
                anchors.fill: parent
                property ResultModel resultModel: swipeView.resultModels[0]
            }
        }

        Page {
            id: secondPage
            RfResultPage {
                anchors.fill: parent
                property ResultModel resultModel: swipeView.resultModels[1]
            }
        }

        Page {
            id: thirdPage
            RfResultPage {
                anchors.fill: parent
                property ResultModel resultModel: swipeView.resultModels[2]
            }
        }

        Page {
            id: forthPage
            RfResultPage {
                anchors.fill: parent
                property ResultModel resultModel: swipeView.resultModels[3]
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
