#/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
. $SCRIPT_DIR/docker_env


if [ "x$DOCKER_CMD" = "x" ]
then
exit 1
fi

CONTAINER_NAME=none
if [ "x$1" != "x" ]
then
CONTAINER_NAME=$1
fi


DOCKER_ID=`$DOCKER_CMD container ls --all | grep $CONTAINER_NAME | tr '\t' ' ' | cut -d' ' -f1`

if [ "x$DOCKER_ID" != "x" ]
then
echo $DOCKER_ID
fi
