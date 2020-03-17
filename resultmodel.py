from PyQt5.QtCore import *

class ResultModel(QAbstractListModel):

    JumlahPohon = Qt.UserRole + 1
    Akurasi = Qt.UserRole + 2

    def __init__(self, model_data = [], parent=None):
        super().__init__(parent=parent)
        self.model = model_data
        print(model_data)

    def rowCount(self, parent=QModelIndex()):
        return len(self.model)

    def data(self, index, role=Qt.ItemDataRole.DisplayRole):
        row = index.row()
        if role == ResultModel.JumlahPohon:
            return 'Jumlah Pohon: {0}'.format(self.model[row]['jumlah_pohon'])
            
        elif role == ResultModel.Akurasi:
            return 'Akurasi: {}'.format(self.model[row]['akurasi'])

    def roleNames(self):
        return {
            ResultModel.JumlahPohon: b'jumlahPohon',
            ResultModel.Akurasi: b'akurasi'
        }