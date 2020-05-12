import QtQuick 2.0
import QtQuick.Controls 2.5

ComboBox {
    property variant text
    textRole: 'text'
    model: ListModel {

    }

    onCurrentIndexChanged:  {
        text = model.get(currentIndex).value
    }
}
