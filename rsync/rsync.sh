#!/bin/sh

usage () {

	echo " Usage: $0 -c <command> -s <source> -d <destination> -e <exclude_file>"
	echo "     -D or --dry-run      : dry-run"
	echo "     -c or --command      : backup or restore"
	echo "     -s or --source         : change source folder"
	echo "     -d or --dest        : vchange dest folder"
	echo "     -e or --exclude-file      : change exclude file"
	echo "     -h or --help        : usage"
	exit 1
}
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

DEFAULT_BACKUP_FOLDER=/tmp
EXCLUDE_FILE=$SCRIPT_DIR/rsync-excludes.txt
SRC=/home/$USER/
CMD=backup
DEST=/tmp

while true; do
	case $1 in
		-h | --help)
			usage; exit 0;
			shift;
			;;
        -D | --dry)
            echo "dry run"
			DRY=1;
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
			DEST=$2
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

BACKUP_OPTS="-aP"
RESTORE_OPTS="-rltgoDv"

echo "CMD=$CMD"
echo "SRC:$SRC"
echo "DEST=$DEST"

if [ "x$CMD" = "xbackup" ]; then
RSYNC_CMD="rsync $BACKUP_OPTS --exclude-from=$EXCLUDE_FILE $SRC $DEST"
elif [ "x$CMD" = "xrestore" ] ; then
RSYNC_CMD="rsync $RESTORE_OPTS $DEST $SRC"
else
echo "RSYNC_CMD: $RSYNC_CMD not found. Exit."
fi

echo $RSYNC_CMD

if [ ! -z $DRY ]; then
exit 0
fi

eval $RSYNC_CMD
