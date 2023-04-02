{ pkgs, lib }:
{
  bat.enable = true;
  direnv = import ./direnv.nix;
  exa.enable = true;
  firefox.enable = true;
  fish = import ./fish.nix { inherit pkgs lib; };
  git = import ./git.nix;
  home-manager.enable = true;
  i3status-rust = import ./i3status-rust.nix;
  jq.enable = true;
  kitty = import ./kitty.nix { inherit pkgs; };
  neovim = import ./neovim.nix { inherit pkgs; };
  rofi = import ./rofi.nix { inherit pkgs; };
  starship = import ./starship.nix { inherit lib; };
  vscode = import ./vscode.nix { inherit pkgs; };
}
