#!/opt/local/bin/bash

MUTTPRINT=/tmp/muttprint_`date +%s`

cat > ${MUTTPRINT}

SUBJECT=`grep -a '^Subject:' ${MUTTPRINT} | sed 's/^Subject:\ //'`

if ! [ -e "${HOME}/Desktop/${SUBJECT}.txt" ]
then
    FILE="${HOME}/Desktop/${SUBJECT}.txt"
else
    count=1

    while [ -e "${HOME}/Desktop/${SUBJECT}-${count}.txt" ]
    do
        count=$(( $count + 1 ))
    done
    FILE="${HOME}/Desktop/${SUBJECT}-${count}.txt"
fi

#muttprint --debug -p - | ps2pdf - "${FILE}"
#FILE=$(printf %q "$FILE")  # make string safe

cat ${MUTTPRINT} > "${FILE}" 

rm ${MUTTPRINT}

