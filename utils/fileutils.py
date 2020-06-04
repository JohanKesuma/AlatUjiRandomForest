import os
import ntpath

def file_extension(path: str):
        """
        Parameter
        ---------
        path : file path

        Return
        -------
        str - ektensi file

        """

        file_extension = os.path.splitext(path)[1]

        print(os.path.splitext(path))
        return file_extension

def path_leaf(path: str):
    head, tail = ntpath.split(path)
    return tail or ntpath.basename(head)