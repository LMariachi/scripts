#!/bin/sh

MAILTO='-c ludwig@metaspasm.org ludwig@localhost'
PORTUPDATE=/tmp/portupdate_`date +%s`

port selfupdate &> ${PORTUPDATE}
echo -e "\n" >> ${PORTUPDATE}
port outdated >> ${PORTUPDATE} 2>&1

/opt/local/bin/terminal-notifier -title "terminal-notifier" -message "Ports updated"

/usr/bin/mail -s "Port update results" ${MAILTO} < ${PORTUPDATE}

rm ${PORTUPDATE}

