mapfile -t ICON_FILES < <(find /home/minecraft/icons -type f -name "icon*.png")

NUM_ICONS=${#ICON_FILES[@]}

if [ $NUM_ICONS -eq 0 ]; then
    echo "No icon PNG files found."
    exit 1
fi

RAND_INDEX=$((RANDOM % NUM_ICONS))

SELECTED_FILE="${ICON_FILES[$RAND_INDEX]}"

echo "Number of icon PNGs found: $NUM_ICONS"
echo "Selected file: $SELECTED_FILE"

cp $SELECTED_FILE $PWD/server-icon.png
