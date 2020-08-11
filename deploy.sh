#!/bin/bash
LOG_FILE=/home/weeser/log/cis300deploy.log
#exec > >(tee ${LOG_FILE}) 2>&1

date | tee ${LOG_FILE}
echo "pull and clean book html" >> ${LOG_FILE}
cd ../cis300-book-html
git pull
git rm -rf .
git clean -fxd

echo "pull cis300-book and submodules" >> ${LOG_FILE}
cd ../cis300-book
git pull --recurse-submodules

echo "running hugo to generate html" >> ${LOG_FILE}
hugo
echo "pushing HTML to cis300-book-html" >> ${LOG_FILE}
cd ../cis300-book-html
git add .
git commit -m "Automatic Deploy on `date +'%Y-%m-%d %H:%M:%S'`"
git push -u origin master

echo "pull on cs linux and copy to web" >> ${LOG_FILE}
#ssh weeser@cslinux.cs.ksu.edu "cd /home/w/weeser/git-proj/cis300-book-html/ && git pull"
ssh weeser@linux.cs.ksu.edu "cd /home/w/weeser/git-proj/cis300-book-html/ && git pull && rsync -aP --exclude='.git' /home/w/weeser/git-proj/cis300-book-html/ /web/cis300"
echo "completed" >> ${LOG_FILE}
date | tee ${LOG_FILE}
echo "______________________________________________________" >> ${LOG_FILE}
exit 0
