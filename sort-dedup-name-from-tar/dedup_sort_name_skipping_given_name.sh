#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Usage: $0 <Tar File> <Name To Skip>"
    exit 1
fi
TAR_FILE=$1
NAME_TO_SKIP=$2
for fl in `tar -xvf $TAR_FILE`
do
    FILENAME=`basename $fl`
    if [ "$FILENAME" != "" ]; then
        RET=`echo $FILENAME | grep -e "^[#]\{4\}"`
        if [ "$RET" != "" ]; then
	    FOUND=`grep -v "$NAME_TO_SKIP" $fl`
	    if [ $? -eq 0 ]; then
		echo $FILENAME    
	        cat $fl | tr ' ' '\n'|sort -u | xargs >/tmp/result/$FILENAME
	    fi	
        fi
    fi
done
