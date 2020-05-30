#! /bin/sh

touch ~/tmp/rolling_ping

# Append the new ping time.
ping=$(ping -c 1 -W 1 8.8.8.8)
if [[ $? != 0 ]]; then
    echo "fail" > ~/tmp/rolling_ping
else
    cat ~/tmp/rolling_ping | grep "fail"
    [[ $? == 0 ]] && rm ~/tmp/rolling_ping
    ping=$(echo $ping | grep 'rtt' | cut -d '/' -f 5)
    echo $ping >> ~/tmp/rolling_ping
fi

# Only keep the last 10 values.
echo "$(tail ~/tmp/rolling_ping)" > ~/tmp/rolling_ping
