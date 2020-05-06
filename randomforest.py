from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn import metrics
from sklearn.model_selection import KFold, cross_val_score
from sklearn.tree import export_graphviz

from dialogs.rfresultdialog import RFResultDIalog

from resultmodel import ResultModel, HasilPrediksiModel

import pandas as pd

import os

def runRandomForest(dataset: pd.DataFrame, scaler = None):

    labels = ['BB/U', 'PB/U', 'BB/PB']
    attrs = [['Js.L/P', 'Berat B.', 'Umur'], ['Js.L/P', 'Berat B.', 'PB / TB', 'Posisi diukur', 'Umur'], ['Js.L/P', 'Berat B.', 'PB / TB', 'Posisi diukur', 'Umur']]

    # pemisahan atribut dan target
    # attr = dataset[['Js.L/P', 'Berat B.', 'Umur']] # ambil kolom atribut
    # label = dataset[['BB/U']] # ambil kolom target

    n_folds = [3, 5, 7, 9]
    # n_pohon = [10, 20, 60, 100, 200, 400, 600]
    n_pohon = [10]

    models = [] # menyimpan hasil klasifikasi BB/U, PB/U, BB/PB
    tree_index = 0

    for attr_i, label_i in zip(attrs, labels):
        # hasil prediksi disimpan di dalam model
        resultModels = []
        attr = dataset[attr_i]
        label = dataset[label_i]


        for n in n_folds: # untuk setiap fold
            result = [] # list untuk menyimpan hasil akurasi untuk masing - masing jumlah pohon
            kf = KFold(n_splits=n)
            for jumlah_pohon in n_pohon: # untuk setiap jumlah pohon
                sum_akurasi = 0

                # rfList = list dari model random forest, digunakan untuk uji data tunggal
                rf_list = []
                for train_index, test_index in kf.split(attr):
                    # index training dan testing
                    print("TRAIN:", train_index, "TEST:", test_index)

                    # ambil data training
                    x_train, y_train = attr.iloc[train_index,:], label.iloc[train_index]

                    #ambil data testing
                    x_test, y_test = attr.iloc[test_index,:], label.iloc[test_index]

                    # buat model random forest
                    rf = RandomForestClassifier(n_estimators=jumlah_pohon, bootstrap=True, random_state=0, criterion='entropy')
                    rf.fit(x_train, y_train)
                    rf_list.append(rf)

                    # if tree_index < 1:
                    #     export_graphviz(rf.estimators_[9],
                    #     feature_names=attr.columns,
                    #     filled=True,
                    #     out_file='tree.dot',
                    #     rounded=True)
                    #     os.system('dot -Tpng tree.dot -o tree.png')

                    # tree_index += 1
                    categories = label.astype('category').cat.categories
                    

                    # uji data testing dengan model random forest
                    y_predict = rf.predict(x_test)

                    print('y_predict', y_predict)

                    # evaluasi dengan confusion matrix
                    matrix = metrics.confusion_matrix(y_true=y_test, y_pred=y_predict, labels=categories)
                    print(matrix)

                    # hitung akurasi dari confusion matrix yang telah dibangun
                    akurasi = _hitung_akurasi(matrix)
                    sum_akurasi += akurasi
                    print(akurasi)
                # endfor
                rata_akurasi = float(sum_akurasi / n)
                result_i = {
                    'jumlah_pohon': jumlah_pohon,
                    'akurasi': rata_akurasi,
                    'estimators': rf.estimators_,
                    'attr': attr_i,
                    'rf_list': rf_list
                }

                result.append(result_i)
            # endfor
            resultModel = ResultModel(result)
            resultModels.append(resultModel)
        # endfor
        models.append(resultModels)
    # endfor

    dialog = RFResultDIalog(dataset, models, scaler)
    dialog.exec()

def _hitung_akurasi(confusion_matrix):
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

def uji_tunggal(classifier: list, attrValues: list):
    predict_list = []
    for c in classifier:
        predict = c.predict(attrValues)
        predict_list.append(predict[0])
    # end for

    print(predict_list)

    hasilPrediksiModel = HasilPrediksiModel(predict_list)

    return hasilPrediksiModel
