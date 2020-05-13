from ui_mainwindow import Ui_MainWindow
from PyQt5 import QtWidgets

from PyQt5.QtCore import *
from PyQt5.QtQuickWidgets import QQuickWidget

from tablemodel import TableModel
from columnmodel import ColumnModel
from dialogs.normalisasidialog import NormalisasiDialog
from dialogs.rfDialog import RFDialog

from randomforest import runRandomForest

import resource

class MainWindow(QtWidgets.QMainWindow):

    columnModelInited = pyqtSignal()

    def __init__(self, parent = None):
        super().__init__(parent)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)

        quick_widget = self.ui.quickWidget #type: QQuickWidget
        # quick_widget.setSource(QUrl('qrc:/welcomePage.qml'))
        quick_widget.rootContext().setContextProperty('MainWindow', self)
        
        # init table view dengan table model
        self.tableModel = None
        # self.ui.tableView.setModel(self.tableModel)

        # stacked widget
        self.ui.stackedWidget.setCurrentIndex(0)

        # menuQuickWidget
        self.ui.menuQuickWidget.rootContext().setContextProperty('MainWindow', self)

        # columnQuickWidget
        # self.ui.columnQuickWidget.rootContext().setContextProperty('MainWindow', self)
        # self.ui.columnQuickWidget.setSource(QUrl('qrc:/qml/ColumnList.qml'))

        self.scaler = None # pointer ke MinMaxScaler
    
    @pyqtSlot()
    def openDataset(self):
        file_name = QtWidgets.QFileDialog.getOpenFileName(self, 'Open Dataset', QDir.homePath(), "CSV and Excel(*.xls *.xlsx *.csv);;Excel files (*.xls *.xlsx);;CSV Files(*.csv)")
        
        # jika cancel
        if file_name[0] == '' or file_name == None: 
            return
        
        self.tableModel = TableModel.open_dataset(file_name[0])

        # self.columnModel = ColumnModel(self.tableModel.dataset)
        # self.ui.columnQuickWidget.rootContext().setContextProperty('columnModel', self.columnModel)
        # self.columnModelInited.emit()

        if self.tableModel != None:
            self.ui.tableView.setModel(self.tableModel)
            self.ui.stackedWidget.setCurrentIndex(1)
        

    @pyqtSlot()
    def onNormalisasiButton(self):
        dialog = NormalisasiDialog(self.tableModel, self)
        dialog.setWindowTitle('Normalisasi')
        dialog.exec()
        # model = self.tableModel #type: TableModel

        # preprocessing.minMaxNorm(0, 1, self.tableModel.dataset)

        # model.dataChanged.emit(model.index(0, 0), model.index(model.rowCount() - 1, model.columnCount() - 1))

        # print(model.dataset)

    @pyqtSlot()
    def onRandomForestButton(self):
        runRandomForest(self.tableModel.dataset, self.scaler)
        # dialog = RFDialog(self.tableModel.dataset, self)

    @pyqtSlot()
    def onKustomRandomForestButton(self):
        RFDialog(self.tableModel.dataset, self.scaler, self).exec()
        