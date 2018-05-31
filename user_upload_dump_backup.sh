#!/usr/bin/bash

# /user/cloudera/exercise1/userlogs/ should exists before running this script if not run below commands

# hadoop fs -mkdir /user/cloudera/exercise1/
# hadoop fs -mkdir /user/cloudera/exercise1/userlogs/

for filename in ./*csv ; do
hadoop fs -put $filename /user/cloudera/exercise1/userlogs/
done


hive -e "CREATE EXTERNAL TABLE IF NOT EXISTS user_upload_dump (user_id int, file_name STRING,     timestamp STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/cloudera/exercise1/userlogs/' TBLPROPERTIES ('skip.header.line.count'='1');"
