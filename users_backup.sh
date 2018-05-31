#!/usr/bin/bash


echo "Creating backup of table user in hive"

file="user_$(date +%Y%m%d_%H%M%S)"

sqoop import --connect jdbc:mysql://localhost/exercise_1 --username root --password cloudera --split-by id --table user --target-dir /user/cloudera/sqoop-mysql/${file}/ --fields-terminated-by "," --hive-import --hive-table users

echo "Backup Created"

