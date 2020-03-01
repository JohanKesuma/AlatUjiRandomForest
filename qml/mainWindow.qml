import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    Rectangle {
        color: "red"
        anchors.centerIn: parent
        implicitHeight: 250
        implicitWidth: 250
    }

    Button {
        id: closeButton
        x: 8
        y: 8
        text: qsTr("Close")
        onClicked: mainWindow.close()
    }

    TabBar {
        id: tabBar
        x: 152
        y: 72
        width: 240
        position: TabBar.Header
        wheelEnabled: false


        TabButton {
            id: tabButton
            text: qsTr("Tab Button")
            hoverEnabled: true
            focusPolicy: Qt.StrongFocus
        }
        
        TabButton {
            id: tabButton1
            text: qsTr("Tab Button")
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
