#!/usr/bin/bash

# /user/cloudera/exercise1/userlogs/ should exists before running this script if not run below commands

# hadoop fs -mkdir /app/
# hadoop fs -mkdir /app/data/
# hadoop fs -mkdir /app/data/user_upload/

for filename in ./*csv ; do
hadoop fs -put $filename /app/data/user_upload/
done


hive -e "CREATE EXTERNAL TABLE IF NOT EXISTS user_upload_dump (user_id int, file_name STRING,     timestamp STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/app/data/user_upload/' TBLPROPERTIES ('skip.header.line.count'='1');"
