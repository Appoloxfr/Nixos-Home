{ pkgs, lib }:
let
  initFile = ./fish/init.fish;
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
    "py" = "python3";
    "ipy" = "ipython";

    # Git
    "gs" = "git status";
    "ga" = "git add";
    "gd" = "git diff";
    "gc" = "git commit";
    "gcm" = "git commit -m";
    "gl" = "git log";
    "lg" = "lazygit";

    # Bat replace cat
    "cat" = "bat";

    # Nix
    "nix-shell" = "nix-shell --run fish";
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
  interactiveShellInit = (builtins.readFile initFile);
}
