echo --- crontab start: $(date) >> ~/.local/share/mediaselect-fr/logs/cron_launch_record.log

python3 launch_record.py >> ~/.local/share/mediaselect-fr/logs/cron_launch_record.log 2>&1

echo --- crontab end: $(date) >> ~/.local/share/mediaselect-fr/logs/cron_launch_record.log
