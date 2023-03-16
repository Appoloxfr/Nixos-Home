{ pkgs }:
let
  neovim-config = builtins.fetchGit {
    url = "https://github.com/TimotheeDesveaux/nvim-config";
    ref = "refs/heads/main";
    rev = "c8fe64a919b7450a44f00e0dabb21adbf83b1156";
  };
in
{
  enable = true;
  vimAlias = true;
  extraLuaConfig = ''
    package.path = package.path ..
        ";${neovim-config}/lua/?/init.lua;${neovim-config}/lua/?.lua"
    dofile("${neovim-config}/init.lua")
  '';
}
