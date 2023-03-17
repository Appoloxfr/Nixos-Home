{ pkgs }:

let
  buildTools = with pkgs; [
    clang-tools
    flex
    gcc
    gdb
    gnumake
    nodejs
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
    nitrogen
  ];

  documentationTools = with pkgs; [
    gcc.man
    man-db
    man-pages
  ];

  fonts = with pkgs; [
    comic-mono
  ]
  ++ (with pkgs.nerdfonts;
    [
      (override {
        fonts = [ "CascadiaCode" "FiraCode" "JetBrainsMono" ];
      })
    ])
  ;

  games = with pkgs; [
    # Minecraft launcher open source
    prismlauncher
  ];

  gitTools = with pkgs; [
    gitkraken
    gnupg
    pre-commit
  ];

  ideaTools = with pkgs; [
    jetbrains.idea-ultimate
    jetbrains.rider
    vscode-fhs
  ];

  javaTools = with pkgs; [
    jdk17
    maven
  ];

  lspServers = (with pkgs.nodePackages; [
    bash-language-server
    pyright
  ]) ++ (with pkgs; [
    rnix-lsp
  ]);

  miscTools = with pkgs; [
    ripgrep
    wget
  ];

  nixTools = with pkgs; [
    nix
    nixpkgs-fmt
  ];

  pythonTools = with pkgs; [
    poetry
    python310
    python310Packages.black
    python310Packages.ipython
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
++ games
++ gitTools
++ ideaTools
++ javaTools
++ lspServers
++ miscTools
++ nixTools
++ pythonTools
++ shellTools
++ shellVisualizerTools
