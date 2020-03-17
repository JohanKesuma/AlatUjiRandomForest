from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn import metrics
from sklearn.model_selection import KFold, cross_val_score

from dialogs.rfresultdialog import RFResultDIalog

from resultmodel import ResultModel

import pandas as pd

def runRandomForest(dataset: pd.DataFrame):

    # pemisahan atribut dan target
    attr = dataset.iloc[:,0:3] # ambil kolom atribut
    label = dataset.iloc[:,3] # ambil kolom target

    n_folds = [3, 5, 7, 9]
    n_pohon = [10, 20, 60, 100, 200, 400, 600]
    # n_pohon = [10, 20]

    # hasil prediksi disimpan di dalam model
    resultModels = []

    for n in n_folds: # untuk setiap fold
        result = [] # list untuk menyimpan hasil akurasi untuk masing - masing jumlah pohon
        kf = KFold(n_splits=n)
        for jumlah_pohon in n_pohon: # untuk setiap jumlah pohon
            sum_akurasi = 0
            for train_index, test_index in kf.split(attr):
                # index training dan testing
                print("TRAIN:", train_index, "TEST:", test_index)

                # ambil data training
                x_train, y_train = attr.iloc[train_index,:], label.iloc[train_index]

                #ambil data testing
                x_test, y_test = attr.iloc[test_index,:], label.iloc[test_index]

                # buat model random forest
                rf = RandomForestClassifier(n_estimators=jumlah_pohon, bootstrap=True)
                rf.fit(x_train, y_train)

                # uji data testing dengan model random forest
                y_predict = rf.predict(x_test)

                # evaluasi dengan confusion matrix
                matrix = metrics.confusion_matrix(y_true=y_test, y_pred=y_predict)
                print(matrix)

                # hitung akurasi dari confusion matrix yang telah dibangun
                akurasi = hitung_akurasi(matrix)
                sum_akurasi += akurasi
                print(akurasi)
            # endfor
            rata_akurasi = float(sum_akurasi / n)
            result_i = {
                'jumlah_pohon': jumlah_pohon,
                'akurasi': rata_akurasi
            }

            result.append(result_i)
        # endfor
        resultModel = ResultModel(result)
        resultModels.append(resultModel)
    # endfor

    dialog = RFResultDIalog(resultModels)
    dialog.exec()

def hitung_akurasi(confusion_matrix):
    jumlah_data = 0
    jumlah_benar = 0
    panjang_matrix = len(confusion_matrix)
    for i in range(panjang_matrix):
        for j in range(panjang_matrix):
            jumlah_data += confusion_matrix[i][j]
            if i == j:
                jumlah_benar += confusion_matrix[i][j]
            # endif
        # endfor
    # endfor

    return jumlah_benar / jumlah_data
