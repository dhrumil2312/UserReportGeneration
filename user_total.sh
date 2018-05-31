#!/usr/bin/bash


hive -e "create table if not exists user_total as select current_timestamp() time_ran, count(1) total_users, count(1) users_added from user;"

hive -e "insert into user_total select current_timestamp() time_ran, c.present_cnt total_users, c.present_cnt - b.total_users users_added from  (select * from ( select * , row_number() over(order by time_ran desc) rn from user_total) a where rn = 1 ) b , (select count(1) present_cnt from user ) c ;"
