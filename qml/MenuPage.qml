import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Item {

    NumberAnimation on opacity {
        from: 0
        to: 1
        duration: 200
        running: true
    }

    RowLayout {
        anchors.centerIn: parent

        Button {
            id: openDatasetButton
            text: qsTr("Open Dataset")
            flat: true
        }

        ToolSeparator {

        }

        Button {
            id: missingDataButton
            text: qsTr("Missing Data")
            flat: true
            Material.background: Material.Blue
            onClicked: console.log("missing data clicked")
        }

        Button {
            id: normalisasiButton
            text: qsTr("Normalisasi")
            flat: true
            Material.background: Material.Blue
            onClicked: MainWindow.onNormalisasiButton()
        }

        ToolSeparator {

        }

        Button {
            id: randomForestButton
            text: qsTr("Random Forest")
            flat: true
            onClicked: MainWindow.onRandomForestButton()
        }

    }
}




