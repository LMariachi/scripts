#!/opt/local/bin/bash

ls | rsync -az --stats --exclude-from=- --exclude-from='/Users/ludwig/rsync_exclusions' /Users/ludwig/.* /Users/ludwig/dotfile_backups/ &>>errors.txt
