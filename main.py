from ui_mainwindow import Ui_MainWindow
from PyQt5 import QtGui
from PyQt5 import QtWidgets
from PyQt5.QtQml import qmlRegisterType

from columnmodel import ColumnModel

from mainwindow import MainWindow


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)

    qmlRegisterType(ColumnModel, 'RFModel', 1, 0, 'ColumnModel')

    mw = MainWindow()
    mw.show()
    sys.exit(app.exec_())
