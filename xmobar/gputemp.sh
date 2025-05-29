#!/bin/sh

temp=$(nvidia-smi | grep 'Default' | awk '{print $3}' | sed 's/C//')
temp=${temp%???}
percent=$(nvidia-smi | grep 'Default' | awk '{print $13}' | sed 's/C//')


echo "Gpu: $temp°C, $percent"

