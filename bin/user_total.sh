#!/usr/bin/bash


hive -e "insert into user_total select current_timestamp() time_ran, c.present_cnt total_users, c.present_cnt - b.total_users users_added from  (select * from ( select * , row_number() over(order by time_ran desc) rn from user_total) a where rn = 1 ) b , (select count(1) present_cnt from users ) c ;" >> $LOG_HOME/user_total_report.log 2>&1

exit $?
