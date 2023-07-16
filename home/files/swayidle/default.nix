{ pkgs }:
let
  scripts = import ../../programs/scripts/default.nix { inherit pkgs; };
in
{
  default =
    (
      (builtins.readFile ./config) + ''

after-resume "${scripts.reload_wallpaper}"
''
    );

  music =
    (
      (builtins.readFile ./music) + ''

after-resume "${scripts.reload_wallpaper}"
''
    );
}
