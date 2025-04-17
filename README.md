# Andromeda

This repository contains two scripts, chooseIcon.sh and motd.sh, that dynamically randomize the Minecraft server's icon and message of the day (MOTD) on startup.
## Purpose

- chooseIcon.sh: Randomly selects a PNG icon (icon*.png) from /home/minecraft/icons and sets it as the server-icon.png.

- motd.sh: Randomly selects a line from one of the motd*.txt files in /home/minecraft/motd and updates the motd field in your server.properties.

Requirements

- The icons must be stored in: /home/minecraft/icons

- The MOTD text files must be stored in: /home/minecraft/motd

- The Minecraft server.properties file must be located within the server directory or a subdirectory of where the script is called.

## Usage

To use these scripts, call them from your Minecraft server's start.sh script before the server starts.

If your start.sh file is outside the server directory (i.e., the server is in a subdirectory), you must provide the server directory as a parameter when calling motd.sh.
Example start.sh (located one level above the server folder):
```
#!/bin/bash

# Choose a random server icon
./chooseIcon.sh

# Set a random MOTD (pass the path to the server directory)
./motd.sh ./server

# Start the Minecraft server
cd server
java -Xmx2G -Xms1G -jar server.jar nogui
```
## Future Improvements

- Unique Icon and MOTD Per Server

    Add logic to ensure no two concurrently running servers use the same icon or MOTD. This could be done by:

    - Tracking assigned icons and MOTDs in temporary files (e.g., .used_icons, .used_motds)

    - Automatically releasing resources when servers stop