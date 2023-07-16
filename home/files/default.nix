{ pkgs }:
let
  config_swayidle = import ./swayidle/default.nix { inherit pkgs; };
in
{
  ".config/swaylock/config".source = ./swaylock/config;
  ".config/swayidle/config".text = config_swayidle.default;
  ".config/swayidle/music".text = config_swayidle.music;
}
