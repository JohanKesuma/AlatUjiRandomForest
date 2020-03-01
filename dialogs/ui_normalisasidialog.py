# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'normalisasidialog.ui'
#
# Created by: PyQt5 UI code generator 5.14.0
#
# WARNING! All changes made in this file will be lost!


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_NormalisasiDialog(object):
    def setupUi(self, NormalisasiDialog):
        NormalisasiDialog.setObjectName("NormalisasiDialog")
        NormalisasiDialog.resize(431, 248)
        self.verticalLayout = QtWidgets.QVBoxLayout(NormalisasiDialog)
        self.verticalLayout.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout.setObjectName("verticalLayout")
        self.quickWidget = QtQuickWidgets.QQuickWidget(NormalisasiDialog)
        self.quickWidget.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        self.quickWidget.setSource(QtCore.QUrl("qrc:/qml/NormalisasiDialog.qml"))
        self.quickWidget.setObjectName("quickWidget")
        self.verticalLayout.addWidget(self.quickWidget)

        self.retranslateUi(NormalisasiDialog)
        QtCore.QMetaObject.connectSlotsByName(NormalisasiDialog)

    def retranslateUi(self, NormalisasiDialog):
        _translate = QtCore.QCoreApplication.translate
        NormalisasiDialog.setWindowTitle(_translate("NormalisasiDialog", "Dialog"))
from PyQt5 import QtQuickWidgets
