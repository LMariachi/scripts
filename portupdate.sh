#!/opt/local/bin/bash

MAILTO=ludwig@localhost
PORTUPDATE=/tmp/portupdate_`date +%s`

port selfupdate &> ${PORTUPDATE}
echo -e "\n" >> ${PORTUPDATE}
port outdated >> ${PORTUPDATE} 2>&1

mail -s "Port update results" ${MAILTO} < ${PORTUPDATE}

rm ${PORTUPDATE}

