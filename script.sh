#!/bin/bash

# Read output from message.txt
OUTPUT=$(cat msg.txt)

# Read config values from settings.cnf
PORT=$(grep 'port=' setting.cnf | cut -d'=' -f2)

echo "Port: $PORT"
echo "Output: $OUTPUT"

# Create a simple HTML page with the output
echo "$OUTPUT" > index.html

# Check if port is already in use
PID=$(lsof -ti tcp:"$PORT")

if [ -n "$PID" ]; then
  echo "Port $PORT is already in use. Killing process $PID..."
  kill -9 $PID
  sleep 1
fi


# Start a Python web server
echo "Starting server on port $PORT..."
python3 -m http.server "$PORT"

