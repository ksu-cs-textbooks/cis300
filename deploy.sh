#!/bin/bash
TZ=America/Chicago
LOG_FILE=/home/weeser/log/cis300deploy.log
WEBHOOK_URL=https://outlook.office.com/webhook/e27fa57a-e17c-4e4c-aa3a-3eb5d88fc33f@d9a2fa71-d67d-4cb6-b541-06ccaa8013fb/IncomingWebhook/9a0f963775f24cd0b399dcde4aff31b4/a5f5dabb-1e16-468f-a332-9454044ffca0

current_time=$(date)
send_message(){
    JSON="{\"title\": \"${1}\", \"text\": \"${2}\" }"

    # Post to Microsoft Teams.
    curl -H "Content-Type: application/json" -d "${JSON}" "${WEBHOOK_URL}" 2>> ${LOG_FILE}
}

whoami >> ${LOG_FILE}

echo ${current_time} >> ${LOG_FILE}
echo "pull and clean book html git" >> ${LOG_FILE}
send_message "Deploy bot" "pull and clean book html git"

cd ../cis300-book-html
git pull 2>> ${LOG_FILE}
git rm -rf .
git clean -fxd

echo "pulling latest cis300-book master branch and submodules" >> ${LOG_FILE}
send_message "Deploy bot" "pulling latest cis300-book master branch and submodules"
cd ../cis300-book
git pull --recurse-submodules 2>> ${LOG_FILE}

echo "running hugo to generate html" >> ${LOG_FILE}
send_message "Deploy bot" "running hugo to generate html"

hugo 2>> ${LOG_FILE}

echo "pushing HTML to cis300-book-html" >> ${LOG_FILE}
send_message "Deploy bot" "pushing HTML to cis300-book-html"

cd ../cis300-book-html
git add . 2>> ${LOG_FILE}
git commit -m "Automatic Deploy on `date +'%Y-%m-%d %H:%M:%S'`" 2>> ${LOG_FILE}
git push -u origin master 2>> ${LOG_FILE}

echo "pull on cs linux and copy to web directory (this may take a while)" >> ${LOG_FILE}
send_message "Deploy bot" "pull on cs linux and copy to web directory (this may take a while)"

#ssh weeser@cslinux.cs.ksu.edu "cd /home/w/weeser/git-proj/cis300-book-html/ && git pull"
ssh weeser@linux.cs.ksu.edu "cd /home/w/weeser/git-proj/cis300-book-html/ && git pull && rsync -aP --exclude='.git' /home/w/weeser/git-proj/cis300-book-html/ /web/cis300" 2>> ${LOG_FILE}
echo "completed" >> ${LOG_FILE}

send_message "Deploy bot" "Finished deploying CIS 300 Book"
echo "______________________________________________________" >> ${LOG_FILE}
exit 0
