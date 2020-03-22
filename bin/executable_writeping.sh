#! /bin/sh

touch ~/tmp/rolling_ping

# Append the new ping time.
ping=$(ping -c 1 -W 1 8.8.8.8 | grep 'rtt' | cut -d '/' -f 5)
echo $ping >> ~/tmp/rolling_ping

# Only keep the last 10 values.
echo "$(tail ~/tmp/rolling_ping)" > ~/tmp/rolling_ping
