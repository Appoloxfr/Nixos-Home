{ lib }:
let
  settings = {
    add_newline = false;
    format = lib.concatStrings [
      "$username"
      "$hostname"
      "$localip"
      "$shlvl"
      "$singularity"
      "$kubernetes"
      "$directory"
      "$vcsh"
      "$git_branch"
      "$git_commit"
      "$git_state"
      "$git_metrics"
      "$git_status"
      "$hg_branch"
      "$docker_context"
      "$package"
      "$c"
      "$cmake"
      "$dotnet"
      "$haskell"
      "$helm"
      "$java"
      "$kotlin"
      "$nodejs"
      "$ocaml"
      "$python"
      "$rust"
      "$terraform"
      "$vagrant"
      "$nix_shell"
      "$meson"
      "$azure"
      "$env_var"
      "$custom"
      "$sudo"
      "$cmd_duration"
      "$line_break"
      "$jobs"
      "$container"
      "$shell"
      "$character"
      "$status"
    ];
    scan_timeout = 10;
    cmd_duration = { show_milliseconds = true; };
    character = {
      success_symbol = "[➜](bold green) ";
      error_symbol = "[✗](bold red)";
    };
    battery = { disabled = true; };
    status = {
      disabled = false;
      format = "[\\[$status\\]]($style) ";
    };
  };
in
{
  enable = true;
  enableBashIntegration = false;
  enableFishIntegration = true;
  enableIonIntegration = false;
  enableZshIntegration = false;

  inherit settings;
}
