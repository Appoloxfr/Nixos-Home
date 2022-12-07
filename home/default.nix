{ pkgs, system, stateVersion, username, homeDirectory }:
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
    inherit pkgs;
  };
}
