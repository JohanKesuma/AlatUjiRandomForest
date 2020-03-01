from PyQt5 import QtCore
import pandas as pd

class TableModel(QtCore.QAbstractTableModel):

    def __init__(self, parent=None):
        super().__init__(parent=parent)
        self.dataset = None #type: pd.DataFrame()

    def rowCount(self, parent=QtCore.QModelIndex()):
        return self.dataset.shape[0]

    def columnCount(self, parent=QtCore.QModelIndex()):
        return self.dataset.shape[1]

    def headerData(self, section, orientation, role=QtCore.Qt.DisplayRole):
        if role == QtCore.Qt.DisplayRole:
            if orientation == QtCore.Qt.Horizontal:
                return self.dataset.columns[section]
            else:
                return section
            

    def data(self, index, role=QtCore.Qt.DisplayRole):
        if role == QtCore.Qt.DisplayRole:
            return str(self.dataset.iloc[index.row()][index.column()])

    @staticmethod
    def open_dataset(url: str, parent = None):
        """
        Parameter
        ---------
        url : file path

        Return
        -------
        TableModel - jika url tidak Null

        None - jika url null

        """

        if url != '':
            table_model = TableModel(parent)
            table_model.dataset = pd.read_excel(url)
            return table_model
        else:
            return None

        
        
