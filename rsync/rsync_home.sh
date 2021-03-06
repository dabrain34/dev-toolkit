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

DEFAULT_BACKUP_FOLDER=/media/$USER/COLLA_CRYPT/BACKUP_XPS
EXCLUDE_FILE=$SCRIPT_DIR/rsync-excludes.txt
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

./rsync.sh -c $CMD -s $SRC -d $DEST -e $EXCLUDE_FILE
