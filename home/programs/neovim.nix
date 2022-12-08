{ pkgs }:
let
  plugins = with pkgs.vimPlugins; [
    vim-nix
    vim-airline
  ];
  extraConfig = ''
          set termguicolors

          " tab help
          set expandtab
          set smarttab
          set shiftwidth=2
          " -1 means the same value as shiftwidth
          set softtabstop=-1

          " Set the minimal amount of lignes under and above the cursor
          " Useful for keeping context when moving with j/k
          set scrolloff=8

          set ai " Auto indent
          set si " Smart indent
          set wrap " Wrap lines
          set swapfile!

          set relativenumber
          set number

          set colorcolumn=80

          " Apply automatically formatter

    autocmd BufWritePost *.nix silent !nixpkgs-fmt <afile>
    autocmd BufWritePost *.fish silent !fish_indent <afile>
    autocmd BufWritePost *.py silent !black <afile>
  '';
in
{
  enable = true;
  vimAlias = true;
  inherit extraConfig plugins;
}
