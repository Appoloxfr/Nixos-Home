{ pkgs, system, stateVersion, username, homeDirectory }:
let
  lib = pkgs.lib;
in
{
  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home = {
    inherit homeDirectory stateVersion username;
    packages = import ./packages {
      inherit pkgs;
    };
  };

  # Configuration of programs
  programs = import ./programs {
    inherit pkgs lib;
  };

  xsession = import ./xsession.nix { inherit pkgs lib; };

  services = import ./services;
}
