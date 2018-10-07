#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DIR=`pwd`

#change the for loop separator. Instead of space use linefeed.
IFS=$'\n'

if [ "x$1" != "x" ]; then
    DIR=$1
fi

echo "Rename files in dir $DIR"
FILES=`find $DIR -type f`

for F in $FILES
do
NEW_F=`echo $F | sed -e 's/ /_/g'`
echo "$F renamed to $NEW_F"
mv $F $NEW_F
done 

 
