#!/usr/bin/bash


if ( $1 = "true"); then
sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop --create activitylog.logs -- import --connect jdbc:mysql://localhost/exercise_1 --username root --password-file /user/cloudera/root_pwd.txt --table activitylog --split-by id --hive-import --hive-table activitylog --incremental append --check-column id --last-value 0
sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop --exec activitylog.logs
else
sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop --exec activitylog.logs
fi