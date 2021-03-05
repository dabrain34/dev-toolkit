#!/bin/sh

while true; do
    $1
    EC=$?
    if [ $EC -ne 0 ]; then
        echo "ERROR"
        break
    fi
done
