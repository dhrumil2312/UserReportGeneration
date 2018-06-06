#!/usr/bin/bash


echo " Starting backup of USERS table"

sh users_backup.sh

if [ $? -eq 0 ]
then
	echo "User backup done."
	echo "Starting Activity Log table backup"
else
	echo "Error in creating User Backup. Please check logs/users_backup.log for errors.  Exiting.........." >&2
	exit 1
fi

sh activity_log_backup.sh

if [ $? -eq 0 ]
then
        echo "Activity Log Backup Done........"
        echo "Starting User Upload Dump backup.............."
else
        echo "Error in creating Activity Log Backup. Please check logs/activitylogs.log for errors.  Exiting.........." >&2
        exit 1
fi

sh user_upload_dump_backup.sh

if [ $? -eq 0 ]
then
        echo "User upload dump backup done."
        echo "Generating report for User Total........."
else
        echo "Error in creating User Upload Dump Backup. Please check logs/user_uploads_dump.log for errors.  Exiting.........." >&2
        exit 1
fi

sh user_total.sh

if [ $? -eq 0 ]
then
        echo "User Total Reprot Generated"
        echo "Generating User Report"
else
        echo "Error in generating User Total Report. Please check logs/user_total.log for errors.  Exiting.........." >&2
        exit 1
fi


sh user_report.sh

if [ $? -eq 0 ]
then
        echo "User Report Generated........."
else
        echo "Error in generating User Report. Please check logs/user_report.log for errors.  Exiting.........." >&2
        exit 1
fi

