{ pkgs }:
let
  font = {
    name = "Comic Mono";
    size = 12;
  };
  settings = {
    confirm_os_window_close = 0;
  };
in
{
  enable = true;
  inherit font settings;
}
