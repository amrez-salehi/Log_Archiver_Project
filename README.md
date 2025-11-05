# Log Archiver Project

## Goal

The goal of this project is to **automatically archive system log files** from `/var/log` to a separate folder with a timestamped filename. This makes it easier to manage logs, prevent them from growing too large, and keep a backup of past logs.

---

## Project Steps

### 1. Prepare Source Logs

* Decide which log files you want to archive (e.g., `/var/log/auth.log`, `/var/log/syslog`).
* These files are the **source logs** for the script.

### 2. Create Archive Directory

* Make a folder to store archived logs:

```bash
sudo mkdir /var/log/arc
sudo chmod 755 /var/log/arc
```

### 3. Create the Script

* Create a bash script (e.g., `archive_log.sh`) on your Desktop:

```bash
#!/bin/bash

SOURCE_DIR="/var/log"
ARCHIVE_DIR="/var/log/arc"
FILES=("auth.log" "syslog")  # Add other logs as needed

for file in "${FILES[@]}"; do
    if [ -f "$SOURCE_DIR/$file" ]; then
        TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
        cp "$SOURCE_DIR/$file" "$ARCHIVE_DIR/${file%.log}_$TIMESTAMP.log"
    fi
done
```

* Make it executable:

```bash
chmod +x ~/Desktop/archive_log.sh
```

### 4. Test the Script

* Run it manually to verify it works:

```bash
sudo ~/Desktop/archive_log.sh
```

* Check `/var/log/arc` for new timestamped log files.

### 5. Set Up Automatic Archiving (Cron Job)

* Edit root cron jobs:

```bash
sudo crontab -e
```

* Add a line to run the script daily at 1 AM:

```bash
0 1 * * * /home/asalehi/Desktop/archive_log.sh
```

* Save and exit.

### 6. Verify Cron Job

* List cron jobs to confirm:

```bash
sudo crontab -l
```

* Wait for the scheduled time, then check `/var/log/arc` for new logs.

### 7. Optional Improvements

* **Compress logs**:

```bash
gzip /var/log/arc/*.log
```

* **Remove old logs** automatically after 30 days:

```bash
find /var/log/arc/ -type f -mtime +30 -delete
```

---

## Summary

This project creates a **simple, automated log archiver** that:

* Saves selected logs with timestamps.
* Keeps an organized archive folder.
* Can run automatically via cron.
* Can optionally compress or clean old logs.


this project done base on this project url idea
https://roadmap.sh/projects/log-archive-tool
