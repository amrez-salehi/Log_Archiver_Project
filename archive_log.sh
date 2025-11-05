#!/bin/bash

# Source directory of logs
SOURCE_DIR="/var/log"

# Archive directory
ARCHIVE_DIR="/var/log/arc"

# List of log files to archive
FILES=("auth.log" "syslog")  # add more if needed

# Loop through files and copy with timestamp
for file in "${FILES[@]}"; do
    if [ -f "$SOURCE_DIR/$file" ]; then
        TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
        cp "$SOURCE_DIR/$file" "$ARCHIVE_DIR/${file%.log}_$TIMESTAMP.log"
    fi
done
