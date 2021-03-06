#/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
. $SCRIPT_DIR/docker_env

if [ "x$DOCKER_CMD" = "x" ]
then
exit 1
fi

set -x
$DOCKER_CMD container ls --all
