#!/bin/sh

usage () {

	echo " Usage: $0 -c <command> -s <source> -d <destination> -e <exclude_file>"
	echo "     -c or --command      : backup or restore"
	echo "     -s or --source         : change source folder"
	echo "     -d or --dest        : vchange dest folder"
	echo "     -e or --exclude-file      : change exclude file"
	echo "     -h or --help        : usage"
	exit 1
}

DEFAULT_BACKUP_FOLDER=/media/$USER/COLLA_CRYPT/BACKUP_XPS
EXCLUDE_FILE=rsync-excludes.txt
SRC=/home/$USER/
DEST=/media/$USER/COLLA_CRYPT/BACKUP_XPS
CMD=backup

while true; do
	case $1 in
		-h | --help)
			usage; exit 0;
			shift;
			;;
		-c | --command)
			if [ "$2" != "backup" -a "$2" != "restore" ]; then
				echo "command"
				echo "Using default --> backup"
			else
				CMD=$2
			fi
			shift; shift;
			;;
		-s | --source)
            SRC=$2
			shift; shift;
			;;
		-d | --dest)
			SRC=$2
			shift; shift;
			;;
        -e | --exclude-file)
			EXCLUDE_FILE=$2
			shift; shift;
			;;

		--)
			shift; break;
			;;
		*)
			break;
	esac
done

set -x
echo $CMD
if [ "x$CMD" = "xbackup" ]; then
rsync -aP --exclude-from=$EXCLUDE_FILE $SRC $DEST
elif [ "x$CMD" = "xrestore" ] ; then
rsync -aP $DEST $SRC
else
echo "CMD: $CMD not found. Exit."
fi
