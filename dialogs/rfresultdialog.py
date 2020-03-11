from PyQt5.QtWidgets import QDialog
from PyQt5 import QtCore
from PyQt5.QtCore import Qt
from PyQt5.QtQml import qmlRegisterUncreatableType

from dialogs.ui_rfresultdialog import Ui_RFResultDialog

class RFResultDIalog(QDialog):

    resultModelInited = QtCore.pyqtSignal()

    def __init__(self, resultModel, parent=None, flags=Qt.WindowFlags()):
        super().__init__(parent=parent, flags=flags)

        # TODO init ui
        self.ui = Ui_RFResultDialog()
        self.ui.setupUi(self)

        self.resultModel = resultModel
        self.ui.quickWidget.rootContext().setContextProperty('resultModel', self.resultModel)
        self.ui.quickWidget.rootContext().setContextProperty('RootDialog', self)
        self.ui.quickWidget.setSource(QtCore.QUrl("qrc:/qml/rfResultDialog.qml"))
        self.resultModelInited.emit()

    