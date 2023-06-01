#!/bin/bash

# Runs first script
./bin/download.sh

#Check if first script is still running
while pgrep -f "script1.sh" > /dev/null; do
  sleep 1
done

# Run second script
./bin/cleanup.sh

# Check if second script is still running
while pgrep -f "script2.sh" > /dev/null; do
  sleep 1
done

# Run third script
./bin/data.sh

# Check if third script is still running
while pgrep -f "script3.sh" > /dev/null; do
  sleep 1
done

# Write the result to the console
echo "-----------------FINISHED-----------------"
