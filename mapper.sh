#!/usr/bin/bash

nohup sqoop metastore &

echo " Starting backup of USERS table"

source users_backup.sh

echo "User backup done."

echo "Starting Activity Log table backup"

source activity_log_backup.sh false

echo " Activity log backup done"

echo " Starting User Upload Dump Backup"

source user_upload_dump_backup.sh

echo " User UPLOAD  Dump backup done"

echo " Generating report for User Total"

source user_total.sh

echo " User Total Report Generated"

echo " Generating User Report"

source user_report.sh

echo "User Report Generated"