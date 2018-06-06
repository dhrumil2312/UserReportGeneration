nohup sqoop metastore &

hive -e "create table  user_total as select current_timestamp() time_ran, 0 total_users, 0 users_added ;"

sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop --create activitylog.logs -- import --connect jdbc:mysql://localhost/exercise_1 --username root --password-file /user/cloudera/root_pwd.txt --table activitylog --split-by id --hive-import --hive-table activitylog --incremental append --check-column id --last-value 0
