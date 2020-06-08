import os
from shutil import move
from os import walk
from builtins import any
from bs4 import BeautifulSoup

path = "G:\\workspace\\cis300-book\\old book"
count = 1


def get_files(filenames, ext=".md"):
    return list(filter(lambda f: f.endswith(ext), filenames))


for (dirpath, dirnames, filenames) in walk(path):
    for file in get_files(filenames):
        old_path = dirpath + os.sep + file
        new_dir = path + os.sep + "markdown" + os.sep + os.sep.join(os.path.normpath(dirpath).split(os.sep)[5:]) + os.sep
        print(new_dir)
        if not os.path.exists(new_dir):
            os.makedirs(new_dir)
        move(old_path, new_dir + os.sep + file)