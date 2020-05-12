from PyQt5.QtCore import *
class KelasModel(QAbstractListModel):

    Kelas = Qt.UserRole + 1
    Attr = Qt.UserRole + 2

    def __init__(self, parent=None):
        super().__init__(parent=parent)
        self._model = [
            {
                'kelas': 'BB/U',
                'attr': ['Js.L/P', 'Berat B.', 'Umur']
            },
            {
                'kelas': 'PB/U',
                'attr': ['Js.L/P', 'Berat B.', 'PB / TB', 'Posisi diukur', 'Umur']
            },
            {
                'kelas': 'BB/PB',
                'attr': ['Js.L/P', 'Berat B.', 'PB / TB', 'Posisi diukur', 'Umur']
            }
        ]

    def data(self, index, role=Qt.ItemDataRole.DisplayRole):
        row = index.row()
        if role == KelasModel.Kelas:
            return self._model[row]['kelas']
        elif role == KelasModel.Attr:
            return self._model[row]['attr']

    def rowCount(self, parent=QModelIndex()):
        return len(self._model)

    def roleNames(self):
        return {
            KelasModel.Kelas: b'kelas',
            KelasModel.Attr: b'attr'
        }

    @pyqtSlot(int, str,result='QVariant')
    def get(self, index, key):
        return self._model[index][key]