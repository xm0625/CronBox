#! /bin/bash

echo "*/1 * * * * sleep 0s;/CronRootSync.sh" > /tmp/cron_root_tmp;
echo "*/1 * * * * sleep 10s;/CronRootSync.sh" >> /tmp/cron_root_tmp;
echo "*/1 * * * * sleep 20s;/CronRootSync.sh" >> /tmp/cron_root_tmp;
echo "*/1 * * * * sleep 30s;/CronRootSync.sh" >> /tmp/cron_root_tmp;
echo "*/1 * * * * sleep 40s;/CronRootSync.sh" >> /tmp/cron_root_tmp;
echo "*/1 * * * * sleep 50s;/CronRootSync.sh" >> /tmp/cron_root_tmp;
if [ -e "/data/cron_root.txt" ]; then
    cat /data/cron_root.txt >> /tmp/cron_root_tmp;
fi

if [ `md5sum /tmp/cron_root_tmp | awk -F\  '{print $1}'` != `md5sum /var/spool/cron/root | awk -F\  '{print $1}'` ]; then
    cat /tmp/cron_root_tmp > /var/spool/cron/root;
    echo "CronRootSync: FileChanged";
    exit;
fi
echo "CronRootSync: FileNoChange";

