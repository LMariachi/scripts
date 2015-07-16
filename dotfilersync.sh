#!/bin/sh

MAILTO=ludwig@localhost
RSYNC=/tmp/rsyncresults_`date +%s`

ls /Users/ludwig/ | rsync -avz --stats --exclude-from=- --exclude-from='/Users/ludwig/.rsync_exclusions' /Users/ludwig/.* /Users/ludwig/dotfiles/ 1>${RSYNC} 2>>${RSYNC}

/opt/local/bin/terminal-notifier -title "terminal-notifier" -message "dotfiles rsynced"

/usr/bin/mail -s "dotfile rsync results" ${MAILTO} < ${RSYNC}
rm ${RSYNC}

