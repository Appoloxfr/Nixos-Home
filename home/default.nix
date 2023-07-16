{ pkgs, system, stateVersion, username, homeDirectory }:
let
  lib = pkgs.lib;
in
rec {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      waybar = prev.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        postPatch = (oldAttrs.postPatch or "") + ''
          sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp'';
      });
    })
  ];

  home = {
    inherit homeDirectory stateVersion username;
    packages = import ./packages {
      inherit pkgs;
    };
    file = import ./files { inherit pkgs; };
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
  wayland = import ./wayland.nix { inherit pkgs; };

  services = import ./services { inherit pkgs; };
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
}
