#!/bin/bash

# Function to find server.properties dynamically
find_server_properties() {
    local search_dir="$1"
    
    # Look for server.properties in the given directory or parent directories
    while [ "$search_dir" != "/" ]; do
        if [ -f "$search_dir/server.properties" ]; then
            echo "$search_dir/server.properties"
            return
        fi
        search_dir=$(dirname "$search_dir")
    done

    echo "server.properties not found!"
    exit 1
}

# If the script is being called with a path, use that; otherwise, use the current directory
if [ -n "$1" ]; then
    SERVER_PROPERTIES="$1/server.properties"
else
    SERVER_PROPERTIES=$(find_server_properties "$(pwd)")  # Find it starting from the current directory
fi

# Check if server.properties exists
if [ ! -f "$SERVER_PROPERTIES" ]; then
    echo "server.properties not found in $SERVER_PROPERTIES"
    exit 1
fi

# Find all text files for MOTD 
mapfile -t MOTD_FILES < <(find /home/minecraft/motd -type f -name "motd*.txt")

NUM_MOTD=${#MOTD_FILES[@]}

if [ $NUM_MOTD -eq 0 ]; then
    echo "No MOTD files found."
    exit 1
fi

# Pick a random file
RAND_INDEX=$((RANDOM % NUM_MOTD))
SELECTED_FILE="${MOTD_FILES[$RAND_INDEX]}"

# Get number of lines
NUM_LINES=$(wc -l < "$SELECTED_FILE")
RAND_LINE=$((RANDOM % NUM_LINES + 1))

# Get the selected line
SELECTED_LINE=$(sed -n "${RAND_LINE}p" "$SELECTED_FILE")

echo "Number of MOTD FILES found: $NUM_MOTD"
echo "Number of lines in selected file: $NUM_LINES"
echo "Random line number: $RAND_LINE"
echo "Selected line: $SELECTED_LINE"

# Escape special characters
ESCAPED_LINE=$(echo "$SELECTED_LINE" | sed 's/\\/\\\\/g; s/:/\\:/g')

# Replace or add `motd=` in the found server.properties
if grep -q "^motd=" "$SERVER_PROPERTIES"; then
    sed -i.bak "s/^motd=.*/motd=$ESCAPED_LINE/" "$SERVER_PROPERTIES"
else
    echo "motd=$ESCAPED_LINE" >> "$SERVER_PROPERTIES"
fi

echo "Updated server.properties with new MOTD!"