{ pkgs }:
{
  reload_wallpaper = pkgs.writers.writePython3 "reload_wallpaper" { }
    (builtins.readFile ./swww/wallpaper-reload.py);
}
