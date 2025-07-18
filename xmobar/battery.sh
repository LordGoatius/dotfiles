#!/bin/sh

battery_high=75 # green
battery_med=50 # yellow
battery_low=25 # orange

battery=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "state|to\ full|to\ empty|percentage" | grep 'percentage:' | awk '{print $2}' | sed 's/%//')
battery=$((battery+0))

# for charging status
# can either be 'Full,' 'Charging,' Or 'Discharging,'
# acpi | grep 'Battery 1' | awk '{print $3}'

if [ $battery -gt $battery_high ]
then
    battery="<fc=#32CD32>$battery</fc>%"
elif [ $battery -gt $battery_med ]
then
    battery="<fc=#FFEA00>$battery</fc>%"
elif [ $battery -gt $battery_low ]
then
    battery="<fc=#FFA500>$battery</fc>%"
else
    battery="<fc=#FF0000>$battery</fc>%"
fi

charging=$(acpi | grep 'remaining' | awk '{print $3}') 

if [ "$charging" = "Discharging," ] ; then 
    echo "<fc=#666666><fn=1></fn></fc>-$battery "
elif [ "$charging" =  "" ] ; then
    echo "<fc=#32CD32><fn=1></fn></fc>-$battery"
else
    echo $battery
fi
