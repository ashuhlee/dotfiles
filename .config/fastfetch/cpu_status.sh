#!/bin/bash

# Get CPU usage using top command (most reliable on macOS)
cpu_usage=$(top -l 2 -n 0 | grep "CPU usage" | tail -1 | awk '{print $3}' | sed 's/%//' | cut -d'.' -f1)

# If top fails, try alternative method
if [[ ! $cpu_usage =~ ^[0-9]+$ ]] || [ -z "$cpu_usage" ]; then
    cpu_usage=$(ps -A -o %cpu | awk 'BEGIN{sum=0} {sum+=$1} END{printf "%.0f", sum}')
fi

# If still no valid result, default to 0
if [[ ! $cpu_usage =~ ^[0-9]+$ ]]; then
    cpu_usage=0
fi

# Determine status based on your thresholds
if [ "$cpu_usage" -lt 50 ]; then
    echo "${cpu_usage}% Normal"
elif [ "$cpu_usage" -lt 80 ]; then
    echo "${cpu_usage}% Moderate"
else
    echo "${cpu_usage}% High"
fi
