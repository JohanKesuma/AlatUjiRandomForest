# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'rfdialog.ui'
#
# Created by: PyQt5 UI code generator 5.14.1
#
# WARNING! All changes made in this file will be lost!


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_RFDialog(object):
    def setupUi(self, RFDialog):
        RFDialog.setObjectName("RFDialog")
        RFDialog.resize(1200, 680)
        self.verticalLayout = QtWidgets.QVBoxLayout(RFDialog)
        self.verticalLayout.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout.setObjectName("verticalLayout")
        self.quickWidget = QtQuickWidgets.QQuickWidget(RFDialog)
        font = QtGui.QFont()
        font.setFamily("Noto Sans")
        self.quickWidget.setFont(font)
        self.quickWidget.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        self.quickWidget.setSource(QtCore.QUrl("qrc:/qml/rfDialog.qml"))
        self.quickWidget.setObjectName("quickWidget")
        self.verticalLayout.addWidget(self.quickWidget)

        self.retranslateUi(RFDialog)
        QtCore.QMetaObject.connectSlotsByName(RFDialog)

    def retranslateUi(self, RFDialog):
        _translate = QtCore.QCoreApplication.translate
        RFDialog.setWindowTitle(_translate("RFDialog", "Random Forest"))
from PyQt5 import QtQuickWidgets
