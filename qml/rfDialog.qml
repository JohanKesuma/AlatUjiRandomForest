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

        RowLayout {
            Rectangle {
                id: menu
                width: 200
                Layout.fillHeight: true
                ListView {
                    property var cItem: currentItem
                    anchors.fill: parent
                    id: menuListView
                    currentIndex: 0

                    model: ListModel {
                        ListElement {
                            title: "Cross Validation"
                            source: "CrossValidationRandomForest.qml"
                        }
                        ListElement {
                            title: "Pilih Data Testing"
                            source: "TrainingTestingRandomForest.qml"
                        }
                    }

                    delegate: ItemDelegate {
                        width: parent.width
                        text: model.title
                        highlighted: {
                            if (menuListView.currentIndex === index)
                                return true
                            else
                                return false
                        }

                        onClicked: {
                            if (menuListView.currentIndex != index) {
                                menuListView.currentIndex = index
                                rfStack.replace(model.source)
                            }
                        }
                    }

                    ScrollIndicator.vertical: ScrollIndicator {}
                }
            }

            ToolSeparator {
                orientation: "Vertical"
                Layout.fillHeight: true
                leftPadding: 0
                rightPadding: 0
            }

            StackView {
                id: rfStack
                initialItem: "CrossValidationRandomForest.qml"
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
        
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
