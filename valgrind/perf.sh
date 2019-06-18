#!/bin/sh
CMD=$1

perf record --call-graph fp $CMD
