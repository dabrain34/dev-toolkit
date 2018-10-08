#!/bin/sh
echo "suck it up $1"
wget -e robots=off -r -k -np $1
find -name "index.html?*" | xargs rm
