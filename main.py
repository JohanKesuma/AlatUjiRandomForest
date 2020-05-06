from ui_mainwindow import Ui_MainWindow
from PyQt5 import QtGui
from PyQt5 import QtWidgets
from PyQt5.QtCore import *
from PyQt5.QtQml import qmlRegisterType

from columnmodel import ColumnModel
from resultmodel import ResultModel, HasilPrediksiModel

from mainwindow import MainWindow


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)

    qmlRegisterType(ColumnModel, 'RFModel', 1, 0, 'ColumnModel')
    qmlRegisterType(ResultModel, 'RFModel', 1, 0, 'ResultModel')
    # qmlRegisterType(HasilPrediksiModel, 'RFModel', 1, 0, 'HasilPrediksiModel')

    qmlRegisterType(QAbstractListModel, 'RFModel', 1, 0, 'QAbstractListModel')

    mw = MainWindow()
    mw.show()
    sys.exit(app.exec_())
