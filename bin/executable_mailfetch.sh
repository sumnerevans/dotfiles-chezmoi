#!/usr/bin/env sh
# Dependencies
# - mbsync: for downloading the mail
#       community/isync

[[ "$1" == "--force" ]] && force=1

ping -c 1 8.8.8.8
if [[ ! $force && "$?" != "0" ]]; then
    echo "Exiting..."
    exit 1
fi

pid=$(pgrep mbsync)

if pgrep mbsync &>/dev/null; then
    echo "Process $pid already running. Exiting..." >&2
    exit 1
fi

# Limit mbsync to only use 4 Mbps
mbsync -aV 2>&1 | tee ~/tmp/mbsync.log
