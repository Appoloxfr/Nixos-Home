import os
import re
import glob
import random

# List of commands to be executed
list_cmd = ["hyprctl hyprpaper unload all"]

# Get all monitors
monitors_outputs = os.popen("hyprctl monitors").read()

# Regex to get all monitors
regex = r"Monitor ([\w-]+)"

# Get all monitors
monitors = re.findall(regex, monitors_outputs)

# Glob all available wallpapers
wallpapers = glob.glob(
    os.path.expanduser("~/Pictures/Background/**/*.png"), recursive=True
)

for monitor in monitors:
    # Get random wallpaper
    wallpaper = random.choice(wallpapers)

    # Add command to list
    list_cmd.append(f'hyprctl hyprpaper preload "{wallpaper}"')
    list_cmd.append(f'hyprctl hyprpaper wallpaper "{monitor},{wallpaper}"')
    # Remove wallpaper from list
    wallpapers.remove(wallpaper)

print(list_cmd)
# Execute all commands and wait for them to finish
for cmd in list_cmd:
    os.system(cmd)
