import QtQuick 2.0
import QtQuick.Layouts 1.12

RowLayout {
    id: rowLayout
    Rectangle {
        id: rect
        anchors.fill: parent
        MouseArea {

            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                console.log(model.name)
            }
            onEntered: {
                animateColorExit.stop()
                animateColor.start()
            }
            onExited: {
                animateColor.stop()
                animateColorExit.start()
            }
        }
        PropertyAnimation {id: animateColor; target: rect; properties: "color"; to: "grey"; duration: 100}
        PropertyAnimation {id: animateColorExit; target: rect; properties: "color"; to: "white"; duration: 100}

    }
    Text {
        text: model.name
        Layout.bottomMargin: 5
        Layout.leftMargin: 5
        Layout.topMargin: 5
    }
    Text {
        text: model.description
        Layout.rightMargin: 5
        Layout.bottomMargin: 5
        Layout.topMargin: 5
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
