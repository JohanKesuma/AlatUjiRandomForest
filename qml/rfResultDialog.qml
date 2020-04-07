import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import RFModel 1.0

ColumnLayout {
    id: columnLayout

    Rectangle {
        id: rectangle1
        Layout.fillWidth: true
        implicitHeight: 30

        TabBar {
            id: resultTabBar
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            background: Rectangle {
                color: "#eeeeee"
            }

            TabButton {
                id: bbuButton
                text: qsTr("BB/U")
                implicitWidth: 100
                onClicked: resultSwipeView.setCurrentIndex(0)
            }
            TabButton {
                id: pbuButton
                text: qsTr("PB/U")
                implicitWidth: 100
                onClicked: resultSwipeView.setCurrentIndex(1)
            }
            TabButton {
                id: bbpbButton
                text: qsTr("BB/PB")
                implicitWidth: 100
                onClicked: resultSwipeView.setCurrentIndex(2)
            }
        }
    }

    SwipeView {
        id: resultSwipeView
        Layout.fillHeight: true
        Layout.fillWidth: true
        onCurrentIndexChanged: resultTabBar.setCurrentIndex(currentIndex)

        // =============Page BB/U====================
        Page {
            id: bbuPage
            ColumnLayout {
                anchors.fill: parent
                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 40
                    Text {
                        text: "BB/U"
                        font.pointSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter

                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 40
                    TabBar {
                        id: bbuTabBar
                        anchors.fill: parent
                        TabButton {
                            text: qsTr("3 Fold")
                            onClicked: bbuSwipeView.currentIndex = 0
                        }

                        TabButton {
                            text: qsTr("5 Fold")
                            onClicked: bbuSwipeView.currentIndex = 1
                        }
                        TabButton {
                            text: qsTr("7 Fold")
                            onClicked: bbuSwipeView.currentIndex = 2
                        }
                        TabButton {
                            text: qsTr("9 Fold")
                            onClicked: bbuSwipeView.currentIndex = 3
                        }
                    }
                }

                SwipeView {
                    id: bbuSwipeView
                    width: 200
                    height: 200
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onCurrentIndexChanged: bbuTabBar.currentIndex = currentIndex
                    property variant resultModels: RootDialog.resultModels[0]
                    property variant nPohon: RootDialog.nPohon()

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: bbuSwipeView.resultModels[0]
                            property variant swipeView: bbuSwipeView
                        }
                    }

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: bbuSwipeView.resultModels[1]
                            property variant swipeView: bbuSwipeView
                        }
                    }

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: bbuSwipeView.resultModels[2]
                            property variant swipeView: bbuSwipeView
                        }
                    }

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: bbuSwipeView.resultModels[3]
                            property variant swipeView: bbuSwipeView
                        }
                    }

                }
            }
        }

        // =============Page PB/U====================
        Page {
            id: pbuPage
            ColumnLayout {
                anchors.fill: parent
                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 40
                    Text {
                        text: "PB/U"
                        font.pointSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter

                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 40
                    TabBar {
                        id: pbuTabBar
                        anchors.fill: parent
                        TabButton {
                            text: qsTr("3 Fold")
                            onClicked: pbuSwipeView.currentIndex = 0
                        }

                        TabButton {
                            text: qsTr("5 Fold")
                            onClicked: pbuSwipeView.currentIndex = 1
                        }
                        TabButton {
                            text: qsTr("7 Fold")
                            onClicked: pbuSwipeView.currentIndex = 2
                        }
                        TabButton {
                            text: qsTr("9 Fold")
                            onClicked: pbuSwipeView.currentIndex = 3
                        }
                    }
                }

                SwipeView {
                    id: pbuSwipeView
                    width: 200
                    height: 200
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onCurrentIndexChanged: pbuTabBar.currentIndex = currentIndex
                    property variant resultModels: RootDialog.resultModels[1] // model PB/U
                    property variant nPohon: RootDialog.nPohon()

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: pbuSwipeView.resultModels[0]
                            property variant swipeView: pbuSwipeView
                        }
                    }

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: pbuSwipeView.resultModels[1]
                            property variant swipeView: pbuSwipeView
                        }
                    }

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: pbuSwipeView.resultModels[2]
                            property variant swipeView: pbuSwipeView
                        }
                    }

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: pbuSwipeView.resultModels[3]
                            property variant swipeView: pbuSwipeView
                        }
                    }

                }
            }
        }

        // =============Page PB/U====================
        Page {
            id: bbpbPage
            ColumnLayout {
                anchors.fill: parent
                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 40
                    Text {
                        text: "BB/PB"
                        font.pointSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter

                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 40
                    TabBar {
                        id: bbpbTabBar
                        anchors.fill: parent
                        TabButton {
                            text: qsTr("3 Fold")
                            onClicked: bbpbSwipeView.currentIndex = 0
                        }

                        TabButton {
                            text: qsTr("5 Fold")
                            onClicked: bbpbSwipeView.currentIndex = 1
                        }
                        TabButton {
                            text: qsTr("7 Fold")
                            onClicked: bbpbSwipeView.currentIndex = 2
                        }
                        TabButton {
                            text: qsTr("9 Fold")
                            onClicked: bbpbSwipeView.currentIndex = 3
                        }
                    }
                }

                SwipeView {
                    id: bbpbSwipeView
                    width: 200
                    height: 200
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onCurrentIndexChanged: bbpbTabBar.currentIndex = currentIndex
                    property variant resultModels: RootDialog.resultModels[2] // model BB/PB
                    property variant nPohon: RootDialog.nPohon()

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: bbpbSwipeView.resultModels[0]
                            property variant swipeView: bbpbSwipeView
                        }
                    }

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: bbpbSwipeView.resultModels[1]
                            property variant swipeView: bbpbSwipeView
                        }
                    }

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: bbpbSwipeView.resultModels[2]
                            property variant swipeView: bbpbSwipeView
                        }
                    }

                    Page {
                        RfResultPage {
                            anchors.fill: parent
                            property ResultModel resultModel: bbpbSwipeView.resultModels[3]
                            property variant swipeView: bbpbSwipeView
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
