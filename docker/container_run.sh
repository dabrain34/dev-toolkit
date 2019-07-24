#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
. $SCRIPT_DIR/docker_env

if [ "x$DOCKER_CMD" = "x" ]
then
exit 1
fi

show_usage() {
echo
echo "Usage: $0 [image] [command](by default bash)"
exit
}

if [ "x$1" != "x" ]
then
DOCKER_IMAGE=$1
else
show_usage
fi

# options
CMD_OPTS=""
if [ "x$2" != "x" ]
then
CMD_OPTS=$2
fi

RUN_OPTS="--rm -t -i"


MOUNT_DEV="-v /home/scerveau/DEV:/workdir/DEV"
MOUNT_OPTS="$MOUNT_DEV"


# Start the docker image
set -x
$DOCKER_CMD container run $RUN_OPTS $MOUNT_OPTS $DOCKER_IMAGE $CMD_OPTS
