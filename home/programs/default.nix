{ pkgs, lib }:
{
  bat.enable = true;
  direnv = import ./direnv.nix;
  exa.enable = true;
  firefox.enable = true;
  fish = import ./fish.nix { inherit pkgs lib; };
  ncmpcpp = import ./ncmpcpp.nix;
  git = import ./git.nix;
  home-manager.enable = true;
  jq.enable = true;
  kitty = import ./kitty.nix { inherit pkgs; };
  neovim = import ./neovim.nix { inherit pkgs; };
  rofi = import ./rofi.nix { inherit pkgs; };
  starship = import ./starship.nix { inherit lib; };
  vscode = import ./vscode.nix { inherit pkgs; };
  waybar = import ./waybar.nix { inherit pkgs; };
  yt-dlp = import ./yt-dlp.nix;
}
