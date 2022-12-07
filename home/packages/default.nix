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
    font-awesome
    font-awesome_5
  ];

  gitTools = with pkgs; [
    git
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

  nixTools = with pkgs; [
    nixpkgs-fmt
  ];

  shellTools = with pkgs; [
    alacritty
    fish
    starship # Pretty prompt
  ];

  shellVisualizerTools = with pkgs; [
    bat
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
++ nixTools
++ shellTools
++ shellVisualizerTools