{ pkgs }:
let
  plugins = [
    pkgs.rofi-emoji
  ];
  extraConfig = {
    modes = [ "window" "drun" "run" "ssh" "emoji" ];
  };
in
{
  enable = true;
  package = pkgs.rofi.override { inherit plugins; };
  inherit plugins extraConfig;
}
