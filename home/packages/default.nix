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


  gitTools = with pkgs; [
    gitkraken
    gnupg
    pre-commit
  ];

  ideaTools = with pkgs; [
    jetbrains.idea-ultimate
    vscode-fhs
  ];

  javaTools = with pkgs; [
    jdk
    maven
  ];

  miscTools = with pkgs; [
    wget
  ];

  nixTools = with pkgs; [
    nixpkgs-fmt
  ];

  pythonTools = with pkgs; [
    python3
  ];

  shellVisualizerTools = with pkgs; [
    mdp
    yq
  ];

in
buildTools
++ communicationTools
++ desktopTools
++ documentationTools
++ fonts
++ gitTools
++ ideaTools
++ javaTools
++ miscTools
++ nixTools
++ pythonTools
++ shellVisualizerTools
