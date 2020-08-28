#! /usr/bin/env bash

device_description=$1

if [[ $device_description == "" ]]; then
    echo "Usage: ./change_audio_sink.sh 'DESCRIPTION OF SINK'"
    exit 1
fi

# Find the index of the device with the given description.
sinks="$(pacmd list-sinks | command grep -e 'index:' -e 'device.description')"
i=0
dev_index=0
activate=0
while IFS= read -r line; do
    if [ $(( $i % 2 )) -eq 0 ]; then
        dev_index="$(echo "$line" | sed -n 's/^.*index: \(.*\)$/\1/p')"
    else
        description="$(echo "$line" | sed -n 's/^.*device.description = "\(.*\)"$/\1/p')"

        if [[ $description =~ $device_description ]]; then
            break
        fi
    fi
    i=$(($i + 1))
done <<< "$sinks"

echo "Switching default sink to: $dev_index"
pacmd set-default-sink $dev_index

sink_inputs="$(pacmd list-sink-inputs | command grep -e 'index:')"
while IFS= read -r line; do
    input_id="$(echo "$line" | sed -n 's/^.*index: \(.*\)$/\1/p')"
    echo "Switching input $input_id to $dev_index"
    pacmd move-sink-input $input_id $dev_index
done <<< "$sink_inputs"

exit 2
