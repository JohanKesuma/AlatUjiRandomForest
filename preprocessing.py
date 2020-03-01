from sklearn.preprocessing import MinMaxScaler
import pandas as pd

def minMaxNorm(min: int, max: int, dataset: pd.DataFrame):
    """

    Parameter
    ---------
    min - minimum value
    
    max - maximum value

    dataset - dataset yang akan dinormaliasi, tipe pandas.DataFrame

    """
    data = dataset.values

    scaler = MinMaxScaler(feature_range=(min, max),copy=True).fit(data)
    result = scaler.transform(data)

    x = pd.DataFrame(result, columns=dataset.columns, index=dataset.index)
    dataset.update(x)