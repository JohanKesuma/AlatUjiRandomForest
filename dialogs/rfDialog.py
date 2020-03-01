from PyQt5.QtWidgets import QDialog
from PyQt5 import QtCore
from PyQt5.QtCore import Qt

from dialogs.ui_rfdialog import Ui_RFDialog
from randomforest import runRandomForest

class RFDialog(QDialog):
    def __init__(self, dataset, parent=None, flags=Qt.WindowFlags()):
        super().__init__(parent=parent, flags=flags)

        self.ui = Ui_RFDialog()
        self.ui.setupUi(self)

        self.dataset = dataset

        self.ui.quickWidget.rootContext().setContextProperty('RootDialog', self)

    @QtCore.pyqtSlot(int, int)
    def onOkButton(self, jumlahPohon, nValidation):
        runRandomForest(self.dataset, jumlahPohon)