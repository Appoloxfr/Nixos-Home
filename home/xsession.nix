{ pkgs, lib }:
let
  mod = "Mod4";
  ws1 = "  1: web  ";
  ws2 = "  2: terminal  ";
  ws3 = "  3: idea  ";
  ws4 = "  4: kraken  ";
  ws5 = "  5  ";
  ws6 = "  6  ";
  ws7 = "  7  ";
  ws8 = "  8: discord  ";
  ws9 = "  9: slack  ";
  ws10 = "  10: thunderbird  ";
  config = {
    modifier = mod;

    keybindings = lib.mkOptionDefault {
      # Focus
      "${mod}+h" = "focus left";
      "${mod}+j" = "focus down";
      "${mod}+k" = "focus up";
      "${mod}+l" = "focus right";

      # Move
      "${mod}+Shift+h" = "move left";
      "${mod}+Shift+j" = "move down";
      "${mod}+Shift+k" = "move up";
      "${mod}+Shift+l" = "move right";

      # My multi monitor setup
      "${mod}+m" = "move workspace to output eDP-1";
      "${mod}+Shift+m" = "move workspace to output HDMI-1";

      # Rofi replace dmenu
      "${mod}+d" =
        "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun -config ~/.config/rofi/rofidmenu.rasi";

      # i3logout
      "${mod}+Shift+e" = "exec xfce4-session-logout";

      # Switch workspace
      "${mod}+1" = "workspace number ${ws1}";
      "${mod}+2" = "workspace number ${ws2}";
      "${mod}+3" = "workspace number ${ws3}";
      "${mod}+4" = "workspace number ${ws4}";
      "${mod}+5" = "workspace number ${ws5}";
      "${mod}+6" = "workspace number ${ws6}";
      "${mod}+7" = "workspace number ${ws7}";
      "${mod}+8" = "workspace number ${ws8}";
      "${mod}+9" = "workspace number ${ws9}";
      "${mod}+0" = "workspace number ${ws10}";

      # Move to workspace
      "${mod}+Shift+1" = "move container to workspace number ${ws1}";
      "${mod}+Shift+2" = "move container to workspace number ${ws2}";
      "${mod}+Shift+3" = "move container to workspace number ${ws3}";
      "${mod}+Shift+4" = "move container to workspace number ${ws4}";
      "${mod}+Shift+5" = "move container to workspace number ${ws5}";
      "${mod}+Shift+6" = "move container to workspace number ${ws6}";
      "${mod}+Shift+7" = "move container to workspace number ${ws7}";
      "${mod}+Shift+8" = "move container to workspace number ${ws8}";
      "${mod}+Shift+9" = "move container to workspace number ${ws9}";
      "${mod}+Shift+0" = "move container to workspace number ${ws10}";
    };

    # i3 my startup commands
    assigns = {
      "${ws8}" = [{ class = "discord"; }];
      "${ws9}" = [{ class = "Slack"; } { class = "Mattermost"; }];
      "${ws10}" = [{ class = "thunderbird"; }];
    };
    startup = [
      { command = "thunderbird"; }
      { command = "discord --start-minimized"; }
      { command = "slack -u"; }
      # Will throw a warning, its normal
      {
        command = "firefox";
        workspace = "${ws1}";
      }
    ];
    colors = {
      focusedInactive = {
        border = "#063340";
        background = "#063340";
        text = "#d9d9d9";
        indicator = "#063340";
        childBorder = "#063340";
      };
      unfocused = {
        border = "#063340";
        background = "#063340";
        text = "#d9d9d9";
        indicator = "#063340";
        childBorder = "#063340";
      };
      focused = {
        border = "#d9d9d9";
        background = "#cecece";
        text = "#000000";
        indicator = "#d9d9d9";
        childBorder = "#d9d9d9";
      };
      background = "#ffffff";
    };
    bars = [{
      position = "bottom";
      id = "bottom";
      # command = "${pkgs.i3status-rust}/bin/i3status-rs";
      statusCommand =
        "${pkgs.i3status-rust}/bin/i3status-rs \${HOME}/.config/i3status-rust/config-bottom.toml";
    }];
  };
in
{
  windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gabs;
    inherit config;
  };
}
