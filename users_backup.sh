#!/usr/bin/bash


echo "Creating backup of table user in hive"

sqoop import --connect jdbc:mysql://localhost/exercise_1 --username root --password cloudera --split-by id --table user --target-dir /user/cloudera/sqoop-mysql/user/ --fields-terminated-by "," --hive-import --hive-table users

echo "Backup Created"

