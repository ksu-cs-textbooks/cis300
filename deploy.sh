#!/bin/bash
LOG_FILE=/home/weeser/log/cis300deploy.log
exec > >(tee ${LOG_FILE}) 2>&1

echo "pull and clean book html"
cd ../cis300-book-html
git pull
git rm -rf .
git clean -fxd

echo "pull cis300-book and submodules"
cd ../cis300-book
git pull --recurse-submodules

echo "running hugo to generate html"
hugo
echo "pushing HTML to cis300-book-html"
cd ../cis300-book-html
git add .
git commit -m "Automatic Deploy on `date +'%Y-%m-%d %H:%M:%S'`"
git push -u origin master

echo "pull on cs linux and copy to web"
#ssh weeser@cslinux.cs.ksu.edu "cd /home/w/weeser/git-proj/cis300-book-html/ && git pull"
ssh weeser@linux.cs.ksu.edu "cd /home/w/weeser/git-proj/cis300-book-html/ && git pull && rsync -aP --exclude='.git' /home/w/weeser/git-proj/cis300-book-html/ /web/cis300"

exit 0
