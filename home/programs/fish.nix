{ pkgs, lib }:
let
  shellAbbrs = {
    # Grep
    "grep" = "grep --color=auto";
    "fgrep" = "fgrep --color=auto";
    "egrep" = "egrep --color=auto";

    # Ls
    "l" = "ls -alh";
    "la" = "ls -a";
    "ll" = "ls -l";
    "lla" = "ls -la";
    "lt" = "ls --git-ignore --tree";

    # Python
    "gs" = "git status";
    "ga" = "git add";
    "gd" = "git diff";
    "gc" = "git commit";
    "gcm" = "git commit -m";
    "gl" = "git log";

    # Bat replace cat
    "cat" = "bat";

    # Upgrade nix
    "upgrade" =
      "sudo nix-channel --update && nix-channel --update && sudo nixos-rebuild switch && home-manager switch";
  };
  shellAliases = {
    "ls" = "exa";
    "tree" = "exa --tree";
  };
  functions = {
    "fish_greeting" = {
      body = lib.concatStringsSep "\n" [
        "echo 'Most visited directories:'"
        "z --list | head -n 5"
      ];
    };

    "ni" = {
      wraps = "nix";
      body = lib.concatStringsSep "\n" [
        "nix $argv"
        "set -l nixret $status"
        "if test (count $argv) -eq 0"
        "  # do nothing"
        "else if test $argv[1] = build"
        "  if test $nixret -eq 0"
        "    notify-send -u low -a Nix -i ~/Pictures/icon-nixos.png -c Build \"Nix build\" \"Build document success\""
        "  else"
        "    notify-send -u low -a Nix -i ~/Pictures/icon-nixos.png -c Build \"Nix build\" \"Build document failed\""
        "  end"
        "end"
      ];
    };
  };
  plugins = [{
    name = "z";
    src = pkgs.fetchFromGitHub {
      owner = "jethrokuan";
      repo = "z";
      rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
      sha256 = "+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
    };
  }];
in
{
  enable = true;
  inherit shellAbbrs shellAliases functions plugins;
}
