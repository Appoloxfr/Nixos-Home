{ pkgs }:

let
  buildTools = with pkgs; [
    clang-tools
    flex
    gcc
    gdb
    gnumake
    nodejs-18_x
    yarn
  ];

  communicationTools = with pkgs; [
    discord
    mattermost-desktop
    slack
    teams
    thunderbird
  ];

  csharpTools = (with pkgs;[
    dotnet-sdk_7
    or-tools
  ]) ++
  (with pkgs.dotnetPackages; [
    NUnit
  ]);

  desktopTools = with pkgs; [
    arandr
    cava
    ffmpeg_6
    mpc-cli
    obs-studio
    pamixer
    xdotool
  ];

  documentationTools = with pkgs; [
    gcc.man
    man-db
    man-pages
  ];

  fonts = with pkgs; [
    comic-mono
    hack-font
  ]
  ++ (with pkgs.nerdfonts;
    [
      (override {
        fonts = [ "CascadiaCode" "FiraCode" "JetBrainsMono" "NerdFontsSymbolsOnly" "Iosevka" ];
      })
    ])
  ;

  formatter = with pkgs; [
    nixpkgs-fmt
    nodePackages.prettier
    python310Packages.black
    rustfmt
    stylua
  ];

  games = with pkgs; [
    # Minecraft launcher open source
    prismlauncher
  ];

  gitTools = with pkgs; [
    gitkraken
    gnupg
    lazygit
    pre-commit
  ];

  ideaTools = with pkgs; [
    jetbrains.idea-ultimate
    jetbrains.rider
  ];

  javaTools = with pkgs; [
    jdk17
    scala
    sbt-with-scala-native
    maven
  ];

  lspServers = (with pkgs.nodePackages; [
    bash-language-server
    pyright
    typescript-language-server
  ]) ++ (with pkgs; [
    rnix-lsp
  ]);

  miscTools = with pkgs; [
    ripgrep
    wget
  ];

  nixTools = with pkgs; [
    nix
  ];

  nvimPluggins = with pkgs.vimPlugins; [
    nvim-treesitter
  ];

  pythonTools = with pkgs; [
    poetry
    python310

    python310Packages.ipython
  ];

  rustTools = with pkgs; [
    cargo
    rustc
  ];

  shellTools = with pkgs; [
    zip
    unzipNLS
  ];

  shellVisualizerTools = with pkgs; [
    mdp
    yq
  ];

in
buildTools
++ communicationTools
++ csharpTools
++ desktopTools
++ documentationTools
++ fonts
++ formatter
++ games
++ gitTools
++ ideaTools
++ javaTools
++ lspServers
++ miscTools
++ nixTools
++ nvimPluggins
++ pythonTools
++ rustTools
++ shellTools
++ shellVisualizerTools
