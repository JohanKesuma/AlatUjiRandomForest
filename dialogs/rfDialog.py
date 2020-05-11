from PyQt5.QtWidgets import QDialog
from PyQt5 import QtCore
from PyQt5.QtCore import Qt

from dialogs.ui_rfdialog import Ui_RFDialog
from randomforest import runRandomForest

from kelasmodel import KelasModel
from randomforest import randomForestOne, tampilPohon, uji_tunggal
from resultmodel import HasilPrediksiModel

import pathlib
import pandas as pd

class RFDialog(QDialog):

    kelasModelChanged = QtCore.pyqtSignal()

    def __init__(self, dataset, scaler = None, parent=None, flags=Qt.WindowFlags()):
        super().__init__(parent=parent, flags=flags)

        self.ui = Ui_RFDialog()
        self.ui.setupUi(self)

        self.dataset = dataset
        self._scaler = scaler

        self.ui.quickWidget.rootContext().setContextProperty('RootDialog', self)
        self.ui.quickWidget.rootContext().setContextProperty('applicationPath', 'file://'+str(pathlib.Path().absolute())+'/')
        self._kelas_model = KelasModel(self)

    @QtCore.pyqtSlot('QVariant', int, list)
    def onTampilButton(self, rf, treeIndex, attr):
        tampilPohon(rf, treeIndex, attr)

    @QtCore.pyqtSlot(int, int)
    def onOkButton(self, jumlahPohon, nValidation):
        runRandomForest(self.dataset, jumlahPohon)

    @QtCore.pyqtProperty(KelasModel, notify=kelasModelChanged)
    def kelasModel(self):
        return KelasModel(self)

    @QtCore.pyqtSlot(int, int, int, result='QVariant')
    def onProsesButton(self, index, jumlah_pohon, n_validation):
        return randomForestOne(self.dataset, self._kelas_model._model[index]['attr'], self._kelas_model._model[index]['kelas'], jumlah_pohon, n_validation)

    @QtCore.pyqtSlot(list, list, list, result=HasilPrediksiModel)
    def onPrediksiButton(self, classifier, attrLabels, attrValues):
        print(attrLabels)

        # normalisasi jika dataset asli di normalisasi
        if self._scaler != None:
            # buat dataframe dengan isi 0 semua
            df = pd.DataFrame(0, columns=self.dataset.iloc[:,0:5].columns, index=range(1))

            # isi atribut yang dibutuhkan untuk klasifikasi
            for i in range(len(attrLabels)):
                df[[attrLabels[i]]] = attrValues[0][i]
            
            # normalisasi dataframe dan ambil atribut yang dibutuhkan
            df = pd.DataFrame(self._scaler.transform(df), columns=df.columns, index=df.index)[attrLabels]
            attrValues = df
            # print(self._dataset)

        print(attrValues)
        model = uji_tunggal(classifier, attrValues)
        model.setParent(self)
        return model
