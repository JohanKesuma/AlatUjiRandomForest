# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'mainwindow.ui'
#
# Created by: PyQt5 UI code generator 5.14.0
#
# WARNING! All changes made in this file will be lost!


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(800, 390)
        font = QtGui.QFont()
        font.setFamily("Noto Sans")
        MainWindow.setFont(font)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.centralwidget)
        self.verticalLayout.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout.setObjectName("verticalLayout")
        self.stackedWidget = QtWidgets.QStackedWidget(self.centralwidget)
        self.stackedWidget.setObjectName("stackedWidget")
        self.welcomePage = QtWidgets.QWidget()
        self.welcomePage.setObjectName("welcomePage")
        self.verticalLayout_2 = QtWidgets.QVBoxLayout(self.welcomePage)
        self.verticalLayout_2.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_2.setObjectName("verticalLayout_2")
        self.quickWidget = QtQuickWidgets.QQuickWidget(self.welcomePage)
        font = QtGui.QFont()
        font.setFamily("Noto Sans")
        self.quickWidget.setFont(font)
        self.quickWidget.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        self.quickWidget.setSource(QtCore.QUrl("qrc:/qml/welcomePage.qml"))
        self.quickWidget.setObjectName("quickWidget")
        self.verticalLayout_2.addWidget(self.quickWidget)
        self.stackedWidget.addWidget(self.welcomePage)
        self.actionPage = QtWidgets.QWidget()
        self.actionPage.setObjectName("actionPage")
        self.verticalLayout_3 = QtWidgets.QVBoxLayout(self.actionPage)
        self.verticalLayout_3.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_3.setSpacing(0)
        self.verticalLayout_3.setObjectName("verticalLayout_3")
        self.menuQuickWidget = QtQuickWidgets.QQuickWidget(self.actionPage)
        self.menuQuickWidget.setMinimumSize(QtCore.QSize(0, 50))
        self.menuQuickWidget.setMaximumSize(QtCore.QSize(16777215, 50))
        self.menuQuickWidget.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        self.menuQuickWidget.setSource(QtCore.QUrl("qrc:/qml/MenuPage.qml"))
        self.menuQuickWidget.setObjectName("menuQuickWidget")
        self.verticalLayout_3.addWidget(self.menuQuickWidget)
        self.splitter = QtWidgets.QSplitter(self.actionPage)
        self.splitter.setMinimumSize(QtCore.QSize(125, 125))
        self.splitter.setOrientation(QtCore.Qt.Horizontal)
        self.splitter.setObjectName("splitter")
        self.columnQuickWidget = QtQuickWidgets.QQuickWidget(self.splitter)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Minimum, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.columnQuickWidget.sizePolicy().hasHeightForWidth())
        self.columnQuickWidget.setSizePolicy(sizePolicy)
        self.columnQuickWidget.setMinimumSize(QtCore.QSize(125, 0))
        font = QtGui.QFont()
        font.setFamily("Noto Sans")
        self.columnQuickWidget.setFont(font)
        self.columnQuickWidget.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        self.columnQuickWidget.setObjectName("columnQuickWidget")
        self.tableView = QtWidgets.QTableView(self.splitter)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Maximum, QtWidgets.QSizePolicy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.tableView.sizePolicy().hasHeightForWidth())
        self.tableView.setSizePolicy(sizePolicy)
        font = QtGui.QFont()
        font.setFamily("Noto Sans")
        self.tableView.setFont(font)
        self.tableView.setObjectName("tableView")
        self.verticalLayout_3.addWidget(self.splitter)
        self.stackedWidget.addWidget(self.actionPage)
        self.verticalLayout.addWidget(self.stackedWidget)
        MainWindow.setCentralWidget(self.centralwidget)

        self.retranslateUi(MainWindow)
        self.stackedWidget.setCurrentIndex(1)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
from PyQt5 import QtQuickWidgets
