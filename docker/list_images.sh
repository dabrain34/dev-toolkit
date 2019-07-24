#/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
. $SCRIPT_DIR/docker_env

if [ "x$DOCKER_CMD" = "x" ]
then
exit 1
fi

IMAGES=
TAG=latest

if [ "x$1" != "x" ]
then
IMAGES=$1
fi

if [ "x$2" != "x" ]
then
TAG=$2
fi

set -x
$DOCKER_CMD images | grep -e "$IMAGES" | grep -e "$TAG"
