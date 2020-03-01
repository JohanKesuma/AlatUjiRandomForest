from PyQt5.QtCore import *

class ResultModel(QAbstractListModel):

    JumlahPohon = Qt.UserRole + 1
    Akurasi = Qt.UserRole + 2

    def __init__(self, parent=None):
        super().__init__(parent=parent)

    def rowCount(self, parent=QModelIndex()):
        return 5

    def data(self, QModelIndex, role=Qt.ItemDataRole.DisplayRole):
        if role == ResultModel.JumlahPohon:
            return 'Jumlah Pohon'
        elif role == ResultModel.Akurasi:
            return 'Akurasi'

    def roleNames(self):
        return {
            ResultModel.JumlahPohon: b'jumlahPohon',
            ResultModel.Akurasi: b'akurasi'
        }