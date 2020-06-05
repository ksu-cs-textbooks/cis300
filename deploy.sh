#!/bin/bash

cd ../cis300-book-html
git pull
git rm -rf .
git clean -fxd

cd ../cis300-book
git pull --recurse-submodules

hugo
cd ../cis300-book-html
git add .
git commit -m "Automatic Deploy on `date +'%Y-%m-%d %H:%M:%S'`"
git push -u origin master

ssh weeser@cslinux.cs.ksu.edu "cd /home/w/weeser/public_html/ && git pull"
#ssh russfeld@cslinux.cs.ksu.edu "cd /home/r/russfeld/cc-website-html && git pull && rsync -aP --exclude='.git' /home/r/russfeld/cc-website-html/ /web/core"

exit 0
