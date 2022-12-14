{ pkgs, lib }:
{
  alacritty = import ./alacritty.nix { inherit pkgs; };
  bat.enable = true;
  direnv = import ./direnv.nix;
  exa.enable = true;
  firefox.enable = true;
  fish = import ./fish.nix { inherit pkgs lib; };
  git = import ./git.nix;
  home-manager.enable = true;
  i3status-rust = import ./i3status-rust.nix;
  jq.enable = true;
  neovim = import ./neovim.nix { inherit pkgs; };
  rofi.enable = true;
  starship = import ./starship.nix { inherit lib; };
}
