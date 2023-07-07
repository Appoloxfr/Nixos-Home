{ pkgs }:
let
  off = pkgs.writeShellScript "off.sh"
    (builtins.readFile ./off.sh);
in
{
  powermenu = pkgs.writeShellScript "powermenu.sh" ''
    pkill rofi
    rofi -show p -modi p:${off} -theme ${./powermenu_theme.rasi}
  '';
}
