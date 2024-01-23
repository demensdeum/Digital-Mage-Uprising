#!/usr/bin/bash

# Test to check a Python server socket reusability on Linux
#
# Dependencies:
#   curl
# Example usage: 
#   ./server_test.sh server.py localhost:8000 100
# Output:
#   + Socket reusability test OK       - on success (exit status = 0)
#   - Socket reusability test FAILED   - on failure (exit status = 1)
#
# See also:
#   https://stackoverflow.com/questions/4465959/python-errno-98-address-already-in-use
#   https://stackoverflow.com/questions/72319941/what-do-socket-sol-socket-and-socket-so-reuseaddr-in-python
#   man 7 socket
#   https://docs.python.org/3/library/socket.html   /Errno 98/

[[ $# < 3 ]] && { echo "The test usage: \"${0} <server.py> <addr:port> <N_times>\""; exit 1; }

if ! which curl > /dev/null; then
    echo 'Error: curl binary not found, it is required by the script' >&2
    echo '       Please, install curl and rerun the test' >&2
    exit 1
fi

# this is for output filtering
set -o pipefail

if (
    for i in `seq $3`; do
        # subshell lets python receive SIGINT
        ( echo "# test $i:"; python "$1" ) & 
        SERVER_PID=$!
        sleep 0.05
        
        # make a connection to the server
        curl -s telnet://$2 2>/dev/null &
        CURL_PID=$!
        sleep 0.05
        
        # sending SIGINT to python easily trigger the isuue
        kill -INT $SERVER_PID
        kill $CURL_PID || exit 1
        wait
    done |& grep -E 'OSError|Serving|# test'
) then
    echo
    echo '+ Socket reusability test OK'
else
    echo
    echo '- Socket reusability test FAILED'
    exit 1
fi
