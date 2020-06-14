from PyQt5.QtWidgets import QDialog
from PyQt5 import QtCore, QtWidgets
from PyQt5.QtCore import Qt

from dialogs.ui_rfdialog import Ui_RFDialog
from randomforest import runRandomForest

from kelasmodel import KelasModel
from randomforest import randomForestOne, randomForestCustomTesting, tampilPohon, uji_tunggal, uji_data_banyak
from resultmodel import HasilPrediksiModel

import pathlib
import pandas as pd

from utils.fileutils import file_extension, path_leaf

class RFDialog(QDialog):

    kelasModelChanged = QtCore.pyqtSignal()

    def __init__(self, dataset, scaler = None, parent=None, flags=Qt.WindowFlags()):
        super().__init__(parent=parent, flags=flags)

        self.ui = Ui_RFDialog()
        self.ui.setupUi(self)

        self.dataset = dataset
        self._scaler = scaler

        self.ui.quickWidget.rootContext().setContextProperty('RootDialog', self)
        self.ui.quickWidget.rootContext().setContextProperty('applicationPath', 'file:/'+str(QtCore.QDir.currentPath())+'/')
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

    @QtCore.pyqtSlot(int, int, int, bool, 'QVariant', result='QVariant')
    def onProsesButton(self, index, jumlah_pohon, n_validation, bootstrap, max_features):
        try:
            # jika max_feature tipenya int
            _max_feature = int(max_features)
        except:
            pass
        else:
            max_features = _max_feature
        
        return randomForestOne(self.dataset, self._kelas_model._model[index]['attr'], self._kelas_model._model[index]['kelas'], jumlah_pohon, n_validation, bootstrap, max_features)
    
    @QtCore.pyqtSlot('QVariant', int, int, bool, 'QVariant', result='QVariant')
    def onProsesTrainingTesting(self, data_testing, index, jumlah_pohon, bootstrap, max_features):
        try:
            # jika max_feature tipenya int
            _max_feature = int(max_features)
        except:
            pass
        else:
            max_features = _max_feature

        df = data_testing.copy()

        if self._scaler != None:
            scaled_data = self._scaler.transform(df.iloc[:,0:5])
            df.iloc[:,0:5] = scaled_data


        return randomForestCustomTesting(self.dataset, df, self._kelas_model._model[index]['attr'], self._kelas_model._model[index]['kelas'], jumlah_pohon, bootstrap, max_features)

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

    @QtCore.pyqtSlot(result='QVariant')
    def openDataset(self):
        file_name, file_type = QtWidgets.QFileDialog.getOpenFileName(self, 'Open Dataset', QtCore.QDir.homePath(), "CSV and Excel(*.xls *.xlsx *.csv);;Excel files (*.xls *.xlsx);;CSV Files(*.csv)")
        
        if file_name == '':
            return

        extension = file_extension(file_name)
        if extension == '.csv':
            dataset = pd.read_csv(file_name)
        elif extension == '.xlsx':
            dataset = pd.read_excel(file_name)
        else:
            return
        
        return [dataset, path_leaf(file_name)]

    @QtCore.pyqtSlot(list, 'QVariant', list, str, result=float)
    def ujiDataBanyak(self, classifiers, data_testing, attr, kelas):
        df = data_testing.copy()

        if self._scaler != None:
            scaled_data = self._scaler.transform(df.iloc[:,0:5])
            df.iloc[:,0:5] = scaled_data

        return uji_data_banyak(classifiers, df, attr, kelas)

