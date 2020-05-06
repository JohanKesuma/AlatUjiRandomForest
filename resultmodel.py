from PyQt5.QtCore import *

class ResultModel(QAbstractListModel):

    JumlahPohon = Qt.UserRole + 1
    Akurasi = Qt.UserRole + 2
    Estimators = Qt.UserRole + 3
    Attr = Qt.UserRole + 4
    RfList = Qt.UserRole + 5

    def __init__(self, model_data = [], parent=None):
        super().__init__(parent=parent)
        self._model = model_data
        # print(model_data)

    def rowCount(self, parent=QModelIndex()):
        return len(self._model)

    def data(self, index, role=Qt.ItemDataRole.DisplayRole):
        row = index.row()
        if role == ResultModel.JumlahPohon:
            return 'Jumlah Pohon: {0}'.format(self._model[row]['jumlah_pohon'])
            
        elif role == ResultModel.Akurasi:
            return 'Akurasi: {}'.format(self._model[row]['akurasi'])
        elif role == ResultModel.Estimators:
            return self._model[row]['estimators']
        elif role == ResultModel.Attr:
            return self._model[row]['attr']
        elif role == ResultModel.RfList:
            return self._model[row]['rf_list']

    def roleNames(self):
        return {
            ResultModel.JumlahPohon: b'jumlahPohon',
            ResultModel.Akurasi: b'akurasi',
            ResultModel.Estimators: b'estimators',
            ResultModel.Attr: b'attr',
            ResultModel.RfList: b'rfList'
        }

    @pyqtProperty(list)
    def model(self):
        return self._model

class HasilPrediksiModel(QAbstractListModel):

    PrediksiStr = Qt.UserRole + 1
    Name = Qt.UserRole + 2

    def __init__(self, model_data = [], parent=None):
        super().__init__(parent=parent)
        self._model = model_data

    def rowCount(self, parent=QModelIndex()):
        return len(self._model)

    def data(self, index, role=Qt.ItemDataRole.DisplayRole):
        row = index.row()

        if role == HasilPrediksiModel.PrediksiStr:
            return self._model[row]
        elif role == HasilPrediksiModel.Name:
            return 'model {}'.format((row + 1))

    def roleNames(self):
        return {
            HasilPrediksiModel.PrediksiStr: b'prediksiStr',
            HasilPrediksiModel.Name: b'name'
        }