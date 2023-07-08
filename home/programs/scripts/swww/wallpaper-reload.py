import os
import re
import glob
import random

# List of commands to be executed
list_cmd = [""]

# Get all monitors
monitors_outputs = os.popen("hyprctl monitors").read()

# Regex to get all monitors
regex = r"Monitor ([\w-]+)"

# Get all monitors
monitors = re.findall(regex, monitors_outputs)

# Glob all available wallpapers (png or gif)
wallpapers = glob.glob(
    os.path.expanduser("~/Pictures/Background/**/*.png"), recursive=True
) + glob.glob(
    os.path.expanduser("~/Pictures/Background/**/*.gif"), recursive=True
)

to_display = {}
for monitor in monitors:
    # Get random wallpaper
    wallpaper = random.choice(wallpapers)

    # Add command to list
    list_cmd.append(
        f'swww img -o {monitor} "{wallpaper}" --transition-type\
                random --transition-fps 60'
    )
    # Remove wallpaper from list
    wallpapers.remove(wallpaper)
    to_display[monitor] = wallpaper

# Prety print + notification
pretty_print = "\n".join(
    [
        f"{monitor}: {wallpaper.split('/')[-1]}"
        for monitor, wallpaper in to_display.items()
    ]
)
list_cmd.append(f"notify-send 'Wallpaper changed' '{pretty_print}'")

# Execute all commands and wait for them to finish
for cmd in list_cmd:
    os.system(cmd)
