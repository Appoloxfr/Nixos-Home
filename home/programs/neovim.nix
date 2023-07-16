{ pkgs }:
let
  neovim-config = "/home/gabriel/Documents/Utils/nvim-config";
  neovim-config-Tim = pkgs.fetchFromGitHub {
    owner = "TimotheeDesveaux";
    repo = "nvim-config";
    rev = "c8fe64a919b7450a44f00e0dabb21adbf83b1156";
    hash = "sha256-EbArPDUr1w2aIr+0y5XeypzaJ32JTRby47Cjw1wtfFg=";
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
