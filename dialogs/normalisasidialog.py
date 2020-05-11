from PyQt5.QtWidgets import QDialog
from PyQt5.QtCore import Qt
from PyQt5.QtCore import pyqtSlot

from dialogs.ui_normalisasidialog import Ui_NormalisasiDialog

import preprocessing

class NormalisasiDialog(QDialog):
    def __init__(self, model, parent=None, flags=Qt.WindowFlags()):
        super().__init__(parent=parent, flags=flags)

        self.parent = parent
        self.model = model

        self.ui = Ui_NormalisasiDialog()
        self.ui.setupUi(self)

        self.ui.quickWidget.rootContext().setContextProperty('DialogRoot', self)

    @pyqtSlot(int, int)
    def onOkButton(self, min=0, max=1):
        model = self.model

        df = model.dataset.iloc[:,0:5]

        # preprocessing.minMaxNorm(min, max, model.dataset.iloc[:,0:5])
        scaler = preprocessing.minMaxNorm(min, max, df)
        self.parent.scaler = scaler # parent adalah main window
        model.dataset.loc[:,0:5] = df

        model.dataChanged.emit(model.index(0, 0), model.index(model.rowCount() - 1, model.columnCount() - 1))
        self.close()
