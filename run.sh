#! /bin/bash

# set the timezone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo Asia/Shanghai > /etc/timezone

/bin/bash /CronRootSync.sh;
/usr/sbin/crond -n -x proc 2>&1 | stdbuf -o0 grep '^log_it' | stdbuf -o0 grep -Ev "CronRootSync.sh" | stdbuf -o0 grep -Ev "FileNoChange"