#!/bin/bash

# Get CPU usage using top command
cpu_usage=$(top -l 2 -n 0 | grep "CPU usage" | tail -1 | awk '{print $3}' | sed 's/%//' | cut -d'.' -f1)

# If top fails, default to 0
if [[ ! $cpu_usage =~ ^[0-9]+$ ]] || [ -z "$cpu_usage" ]; then
    cpu_usage=0
fi

# Determine status based on your thresholds and return just the status
if [ "$cpu_usage" -lt 50 ]; then
    echo "Normal"
elif [ "$cpu_usage" -lt 80 ]; then
    echo "Moderate"
else
    echo "High"
fi
