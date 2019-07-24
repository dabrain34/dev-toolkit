#/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
. $SCRIPT_DIR/docker_env


show_usage() {
echo
echo "Usage: $0 container_name or id"
exit
}

if [ "x$1" != "x" ]
then
DOCKER_IMAGE_NAME=$1
else
show_usage
fi


for ARG in "$@"; do
  DOCKER_IMAGE_NAME=$ARG
  . $SCRIPT_DIR/container_get_id.sh $DOCKER_IMAGE_NAME

  if [ "x$DOCKER_ID" = "x" ]
  then
  echo "Unable to find a docker image for $DOCKER_IMAGE_NAME. Exit"
  exit 1
  fi

  set -x
  echo "Stopping the docker image $BUILDER_NAME with id: $DOCKER_ID" 
  $DOCKER_CMD container stop $DOCKER_ID

  echo "Removing the docker image $BUILDER_NAME with id: $DOCKER_ID" 
  $DOCKER_CMD container rm $DOCKER_ID
done
