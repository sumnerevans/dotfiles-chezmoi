#! /bin/sh

cat ~/tmp/rolling_ping | grep "fail" > /dev/null
[[ $? == 0 ]] && printf "∞" && exit 0
printf "%0.3f" $(cat ~/tmp/rolling_ping | jq -s add/length)
