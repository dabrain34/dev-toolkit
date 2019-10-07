export G_SLICE=always-malloc
export G_DEBUG=gc-friendly
export GLIBCPP_FORCE_NEW=1
export GLIBCXX_FORCE_NEW=1

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

SUPP="--suppressions=$SCRIPT_DIR/glibc-2.3.supp
--suppressions=$SCRIPT_DIR/gst.supp"

OPTS="-v --trace-children=yes --track-fds=yes --time-stamp=yes --tool=memcheck
--leak-check=full --leak-resolution=high --freelist-vol=10000000 --show-reachable=yes
--num-callers=40 ${SUPP}"
GOTO="> result.txt 2>&1"
valgrind $OPTS $* 
