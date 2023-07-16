{ pkgs }:
let
  off = pkgs.writeShellScript "off.sh"
    (builtins.readFile ./off.sh);
  idle_rofi = pkgs.writeShellScript "idle-rofi.sh"
    (builtins.readFile ./idle.sh);
in
{
  powermenu = pkgs.writeShellScript "powermenu.sh" ''
    pkill rofi
    rofi -show p -modi p:${off} -theme ${./powermenu_theme.rasi}
  '';

  idle = pkgs.writeShellScript "idle.sh" ''
    pkill rofi
    rofi -show p -modi p:${idle_rofi} -theme ${./powermenu_theme.rasi}
  '';
}
