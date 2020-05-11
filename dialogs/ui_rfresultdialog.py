# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'rfresultdialog.ui'
#
# Created by: PyQt5 UI code generator 5.14.1
#
# WARNING! All changes made in this file will be lost!


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_RFResultDialog(object):
    def setupUi(self, RFResultDialog):
        RFResultDialog.setObjectName("RFResultDialog")
        RFResultDialog.resize(1200, 680)
        font = QtGui.QFont()
        font.setFamily("Noto Sans")
        RFResultDialog.setFont(font)
        self.horizontalLayout = QtWidgets.QHBoxLayout(RFResultDialog)
        self.horizontalLayout.setContentsMargins(0, 0, 0, 0)
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.quickWidget = QtQuickWidgets.QQuickWidget(RFResultDialog)
        self.quickWidget.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        
        self.quickWidget.setObjectName("quickWidget")
        self.horizontalLayout.addWidget(self.quickWidget)

        self.retranslateUi(RFResultDialog)
        QtCore.QMetaObject.connectSlotsByName(RFResultDialog)

    def retranslateUi(self, RFResultDialog):
        _translate = QtCore.QCoreApplication.translate
        RFResultDialog.setWindowTitle(_translate("RFResultDialog", "Hasil Random Forest"))
from PyQt5 import QtQuickWidgets
