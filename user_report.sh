#!/usr/bin/bash



hive -e "drop table if exists  latest_activity_user;"  >> logs/users_report.log 2>&1

hive -e "drop table if exists  total_activity_user;"   >> logs/users_report.log 2>&1

hive -e "drop table if exists  pre_final;"  >> logs/users_report.log 2>&1

hive -e "drop table if exists  user_files;"   >> logs/users_report.log 2>&1 

hive -e "drop table if exists  user_report;"  >> logs/users_report.log 2>&1


hive -e "create table latest_activity_user as select user_id , type , if(unix_timestamp() - timestamp < 172800,1,0) is_active from (select * from (select * , row_number() over (partition by user_id order by timestamp desc) as rn from activitylog )a  where rn = 1) b;"  >> logs/users_report.log 2>&1

error_latest_activity_user=$?

hive -e "create table total_activity_user as select user_id , sum(total_insert) , sum(total_update) , sum(total_delete) from (select user_id , if(type ='INSERT' , cnt, 0) total_insert, if(type ='UPDATE' , cnt, 0) total_update, if(type ='DELETE' , cnt, 0) total_delete from (select user_id , type , count(1) cnt from activitylog group by user_id , type ) a)b group by user_id ;"  >> logs/users_report.log 2>&1

error_total_activity_user=$?

hive -e "create table pre_final as select a.* ,b.type , b.is_active from total_activity_user a , latest_activity_user b where a.user_id = b.user_id; "  >> logs/users_report.log 2>&1

error_pre_final=$?

hive -e "create table user_files as select user_id , count(1) cnt from user_upload_dump group by user_id ;"  >> logs/users_report.log 2>&1

error_user_files=$?

hive -e "create table user_report as select a.* , if(b.cnt = NULL, 0 ,b.cnt) upload_count from pre_final a left outer join user_files b on (a.user_id = b.user_id) ;"  >> logs/users_report.log 2>&1

error_user_report=$?

error=$(($error_latest_activity_user+$error_total_activity_user+$error_pre_final+$error_user_files+$error_user_report))

if [ $error -eq 0 ]
then
        echo "User Report Generated Successfully......"
else
        echo "Error in creating report.  Please check logs/users_report.log for error. Exiting.........." >&2
        exit 1
fi

