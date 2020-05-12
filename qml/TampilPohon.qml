import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

ColumnLayout {
    Rectangle {
        id: root
        visible: true
        width: parent.width
        property int highestZ: 0
        property real defaultSize: 200
        property var currentFrame: undefined
        property real surfaceViewportRatio: 1.5
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.fillWidth: true
        Layout.fillHeight: true

        Rectangle {
            id: photoFrame
            width: parent.width
            height: parent.height
            //            scale: defaultSize / Math.max(image.sourceSize.width, image.sourceSize.height)
            Behavior on scale { NumberAnimation { duration: 200 } }
            Behavior on x { NumberAnimation { duration: 200 } }
            Behavior on y { NumberAnimation { duration: 200 } }
            border.color: "black"
            border.width: 1
            smooth: true
            antialiasing: true
            //            Component.onCompleted: {
            //                x = Math.random() * root.width - width / 2
            //                y = Math.random() * root.height - height / 2
            //                rotation = Math.random() * 13 - 6
            //            }
            Image {
                id: treeImg
                cache: false
                anchors.centerIn: parent
                height: parent.height - 2
                // anchors.fill: parent
                //                source: applicationPath + "tree.png"
                antialiasing: true
            }
            PinchArea {
                anchors.fill: parent
                pinch.target: photoFrame
                pinch.minimumRotation: -360
                pinch.maximumRotation: 360
                pinch.minimumScale: 0.1
                pinch.maximumScale: 10
                pinch.dragAxis: Pinch.XAndYAxis
                onPinchStarted: setFrameColor();
                property real zRestore: 0
                onSmartZoom: {
                    if (pinch.scale > 0) {
                        photoFrame.rotation = 0;
                        photoFrame.scale = Math.min(root.width, root.height) / Math.max(image.sourceSize.width, image.sourceSize.height) * 0.85
                        photoFrame.x = flick.contentX + (flick.width - photoFrame.width) / 2
                        photoFrame.y = flick.contentY + (flick.height - photoFrame.height) / 2
                        zRestore = photoFrame.z
                        photoFrame.z = ++root.highestZ;
                    } else {
                        photoFrame.rotation = pinch.previousAngle
                        photoFrame.scale = pinch.previousScale
                        photoFrame.x = pinch.previousCenter.x - photoFrame.width / 2
                        photoFrame.y = pinch.previousCenter.y - photoFrame.height / 2
                        photoFrame.z = zRestore
                        --root.highestZ
                    }
                }

                MouseArea {
                    id: dragArea
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: photoFrame
                    scrollGestureEnabled: false  // 2-finger-flick gesture should pass through to the Flickable
                    onPressed: {
                        photoFrame.z = ++root.highestZ;
                        parent.setFrameColor();
                    }
                    onEntered: parent.setFrameColor();
                    onWheel: {
                        if (wheel.modifiers & Qt.ControlModifier) {
                            photoFrame.rotation += wheel.angleDelta.y / 120 * 5;
                            if (Math.abs(photoFrame.rotation) < 4)
                                photoFrame.rotation = 0;
                        } else {
                            photoFrame.rotation += wheel.angleDelta.x / 120;
                            if (Math.abs(photoFrame.rotation) < 0.6)
                                photoFrame.rotation = 0;
                            var scaleBefore = photoFrame.scale;
                            photoFrame.scale += photoFrame.scale * wheel.angleDelta.y / 120 / 10;
                        }
                    }
                }
                function setFrameColor() {
                    if (currentFrame)
                        currentFrame.border.color = "black";
                    currentFrame = photoFrame;
                    currentFrame.border.color = "red";
                }
            }
        }

        //        Image {
        //            id: treeImg
        //            width: parent.width/2
        //            height: parent.height
        //            antialiasing: true
        //            source: applicationPath + "tree.png"
        //        }
    }

    RowLayout {
        Layout.fillWidth: true
        height: 60
        spacing: 10
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Layout.bottomMargin: 10
        Layout.topMargin: 10

        Label {
            text: 'Model'
        }

        ComboBox {
            id: modelComboBox
            // textRole: 'text'
            // model: ListModel {

            // }
            Component.onCompleted: {
                let modelList = []
                for (let index = 0; index < rfList.length; index++) {
                    modelList[index] = ''+ (index + 1);
                }
                
                modelComboBox.model = modelList;
            }
        }

        ToolSeparator {

        }

        Label {
            text: 'Index Pohon : '
        }

        ComboBox {
            id: indexPohonComboBox
            Component.onCompleted: {
                let modelList = []
                for (let index = 0; index < jumlahPohon; index++) {
                    modelList[index] = index + 1
                }
                indexPohonComboBox.model = modelList
            }
        }

        Button {
            text: 'Tampil'
            flat: false
            onClicked: {
                console.log(rfList);
                console.log(attr);
                
                
                // const treeIndex = parseInt(estimatorIndexTextField.text);
                const treeIndex = indexPohonComboBox.currentIndex;
                console.log('Index Pohon : ' + treeIndex);
                
                const rfIndex = modelComboBox.currentIndex;
                RootDialog.onTampilButton(rfList[rfIndex], treeIndex, attr)
                treeImg.source = ''
                treeImg.source = applicationPath + "tree.png"
                if (treeImg.width > root.width) {
                    treeImg.width = root.width
                }
            }
        }

    }
}
