import os
from shutil import move
from os import walk
from builtins import any
from bs4 import BeautifulSoup

path = "G:\\workspace\\cis300-book\\old book"
count = 1


def get_files(filenames, ext=".html"):
    return list(filter(lambda f: f.endswith(ext), filenames))


def overwrite_sym():
    for (dirpath, dirnames, filenames) in walk(path):
        for file in get_files(filenames, ext=".html~"):
            move(dirpath + '\\' + file, dirpath + '\\' + os.path.splitext(file)[0] + '.html')


def delete_sym():
    for (dirpath, dirnames, filenames) in walk(path):
        for file in list(filter(lambda f: f.startswith(".#"), filenames)):
            os.remove(dirpath + '\\' + file)


overwrite_sym()
delete_sym()

for (dirpath, dirnames, filenames) in walk(path):
    print("-" * count + dirpath)
    for file in get_files(filenames):
        soup = BeautifulSoup(open(dirpath + '\\' + file), features="html.parser")
        for s in soup.select('.NAVBAR'):
            s.decompose()
        for s in soup.select('small'):
            "Visual Studio is either a registered trademark"
            if any("Last modified" in part or "registered trademark" in part for part in s.contents):
                s.decompose()
            elif "Copyright" in s.i.text:
                s.decompose()
        for s in soup.select('table'):
            if s.find("a", {'href': 'http://validator.w3.org/check/referer'}) \
                    or s.find("a", {'href': 'http://jigsaw.w3.org/css-validator/check/referer'}):
                print('Deleted table')
                s.decompose()

        with open(dirpath + '\\' + file, 'w', encoding="utf-8") as f:
            f.write(str(soup))
    count += 1
# soup = BeautifulSoup()
