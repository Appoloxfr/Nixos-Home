{ pkgs, system, stateVersion, username, homeDirectory }:
let
  lib = pkgs.lib;
in
rec {
  nixpkgs.config.allowUnfree = true;

  home = {
    inherit homeDirectory stateVersion username;
    packages = import ./packages {
      inherit pkgs;
    };
  };

  # Configuration of programs
  programs = (import ./programs {
    inherit pkgs lib;
  }) // (
    {
      bash = {
        initExtra = ''
          if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
             exec  Hyprland
          fi
        '';
      };
    }
  );

  fonts.fontconfig.enable = true;

  # xsession = import ./xsession.nix { inherit pkgs lib; };
  wayland = import ./wayland.nix;

  services = import ./services;
}
