from PyQt5.QtCore import *
import pandas as pd

class ColumnModel(QAbstractListModel):

    ColumnName = Qt.UserRole + 1
    IsTarget = Qt.UserRole + 2

    def __init__(self, dataset: pd.DataFrame, parent=None):
        """
        Parameter
        ---------
        dataset - referensi ke dataset
        """

        super().__init__(parent=parent)
        self.dataset = dataset
        self.columnNameList = list(self.dataset)
        print(self.columnNameList)

    def rowCount(self, parent=QModelIndex()):
        return self.dataset.shape[1]

    def data(self, index: QModelIndex, role=Qt.DisplayRole):
        row = index.row()

        if role == ColumnModel.ColumnName:
            return self.columnNameList[row]
        elif role == ColumnModel.IsTarget:
            return False


    def roleNames(self):
        return {
            ColumnModel.ColumnName: b'name',
            ColumnModel.IsTarget: b'isTarget'
        }
