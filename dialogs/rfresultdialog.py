from PyQt5.QtWidgets import QDialog
from PyQt5 import QtCore
from PyQt5.QtCore import Qt
from PyQt5.QtQml import qmlRegisterUncreatableType

from dialogs.ui_rfresultdialog import Ui_RFResultDialog

class RFResultDIalog(QDialog):

    resultModelInited = QtCore.pyqtSignal()

    def __init__(self, resultModels, parent=None, flags=Qt.WindowFlags()):
        super().__init__(parent=parent, flags=flags)

        # TODO init ui
        self.ui = Ui_RFResultDialog()
        self.ui.setupUi(self)
        self._resultModels = resultModels

        # self.resultModel = resultModel
        self.ui.quickWidget.rootContext().setContextProperty('resultModel', self._resultModels)
        self.ui.quickWidget.rootContext().setContextProperty('RootDialog', self)
        self.ui.quickWidget.setSource(QtCore.QUrl("qrc:/qml/rfResultDialog.qml"))
        self.resultModelInited.emit()

    @QtCore.pyqtSlot(result=list)
    def resultModels(self):
        return self._resultModels

    @QtCore.pyqtSlot(result=list)
    def nPohon(self):
        n_pohon = []
        for i in self._resultModels[0].model:
            n_pohon.append(i['jumlah_pohon'])
        
        return n_pohon