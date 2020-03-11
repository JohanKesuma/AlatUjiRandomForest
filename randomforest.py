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

    # kf = KFold()
    # kf.get_n_splits(attr)
    # for train_index, test_index in kf.split(attr):
    #     print("TRAIN:", train_index, "TEST:", test_index)
    #     print(attr.ix[train_index])

    # attr_train, attr_test, label_train, label_test = train_test_split(attr, label, test_size=0.3)

    baseJumlahPohon = 10
    data = []
    for i in range(5):
        jumlahPohon = baseJumlahPohon * (i + 1)

        rf = RandomForestClassifier(n_estimators=jumlahPohon, bootstrap=True)
        score = cross_val_score(rf, attr, label, cv = 5)
        print(score)

        # hitung akurasi (rata - rata)
        akurasi = 0
        for i in score:
            akurasi = akurasi + i
        akurasi = akurasi / len(score)
        data_i = {
            'jumlah_pohon': jumlahPohon,
            'akurasi': akurasi
        }
        data.append(data_i)
    # rf.fit(attr_train, label_train)

    # predict = rf.predict(attr_test)
    # print(predict)

    # akurasi = metrics.accuracy_score(label_test, predict)
    # print('Akurasi : ', akurasi)

    resultModel = ResultModel(data)

    dialog = RFResultDIalog(resultModel)
    dialog.exec()

