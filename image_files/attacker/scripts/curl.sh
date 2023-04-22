#!/bin/bash
set -e

# Prepend "netcat" if the first argument is not an executable
if ! type -- "$1" &> /dev/null; then
	set -- /usr/bin/watch -n 1 /usr/bin/curl -s ifconfig.co "$@"
fi
echo "->>>>>> (Executing '"$@"') <<<<<<-"

exec "$@"


