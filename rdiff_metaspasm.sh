#!/opt/local/bin/bash

MAILTO='-c ludwig@localhost ludwig@metaspasm.org'
RDIFFSTATUS=/tmp/rdiffstatus_`date +%s`


if [ ! -e /Volumes/metaspasm ]; then
        mkdir /Volumes/metaspasm
        /opt/local/bin/sshfs metaspasm: /Volumes/metaspasm -C
fi

/opt/local/bin/rdiff-backup -v5 --print-statistics --carbonfile --exclude-globbing-filelist=${HOME}/Desktop/.rdiffexclude ${HOME}/Desktop metaspasm::/home/elmariachi/rdiffbackups/desktop  

/opt/local/bin/rdiff-backup -v5 --print-statistics --carbonfile --exclude-globbing-filelist=${HOME}/Documents/.rdiffexclude ${HOME}/Documents metaspasm::/home/elmariachi/rdiffbackups/documents  

/opt/local/bin/rdiff-backup -v5 --print-statistics --carbonfile --exclude-globbing-filelist=${HOME}/Pictures/.rdiffexclude ${HOME}/Pictures metaspasm::/home/elmariachi/rdiffbackups/pictures  

/opt/local/bin/rdiff-backup -v5 --print-statistics --carbonfile --exclude-sockets --exclude-globbing-filelist=${HOME}/scripts/.rdiffexclude ${HOME}/scripts metaspasm::/home/elmariachi/rdiffbackups/scripts 

#rsync -avz --stats --exclude-from=- --exclude-from='/Users/ludwig/.rsync_exclusions' /Users/ludwig/.* /Users/ludwig/dotfiles/  

/opt/local/bin/rdiff-backup -v5 --print-statistics --carbonfile --exclude-globbing-filelist=${HOME}/dotfiles/.rdiffexclude ${HOME}/dotfiles metaspasm::/home/elmariachi/rdiffbackups/dotfiles  

/opt/local/bin/rdiff-backup -v5 --print-statistics --carbonfile --exclude-sockets --exclude-globbing-filelist=${HOME}/Library/.rdiffexclude ${HOME}/Library metaspasm::/home/elmariachi/rdiffbackups/library

for i in /Volumes/metaspasm/rdiffbackups/*
        do echo -e '\n'$i >> ${RDIFFSTATUS} 2>&1
        /opt/local/bin/rdiff-backup --list-increment-sizes $i >> ${RDIFFSTATUS} 2>&1
done

mail -s "rdiff-backup status" ${MAILTO} < ${RDIFFSTATUS}
rm ${RDIFFSTATUS}


