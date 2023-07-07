{ pkgs }:
let
  rofiScript = import ./rofi/script.nix { inherit pkgs; };
  scripts = import ./scripts { inherit pkgs; };

  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      output = [
        "eDP-1"
        "HDMI-A-1"
      ];
      modules-left = [
        "custom/launcher"
        "wlr/workspaces"
        "temperature"
        "custom/wall"
        "mpd"
        "custom/cava"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "pulseaudio"
        "backlight"
        "memory"
        "cpu"
        "battery"
        "custom/powermenu"
        "tray"
      ];

      "custom/launcher" = {
        "format" = " ";
        "tooltip" = false;
      };

      "wlr/workspaces" = {
        "format" = "{icon}";
        "on-click" = "activate";
      };

      "temperature" = {
        "hwmon-path" = "/sys/class/hwmon/hwmon3/temp1_input";
        "format" = "{temperatureC}°C ";
        "critical-threshold" = 80;
        "format-critical" = "{temperatureC}°C ";
      };

      "custom/wall" = {
        "on-click" = "${scripts.reload_wallpaper}";
        "format" = " 󰠖 ";
        "tooltip" = false;
      };

      "mpd" = {
        "max-length" = 30;
        "format" = "<span foreground='#bb9af7'></span> {title}";
        "format-paused" = " {title}";
        "format-stopped" = "<span foreground='#bb9af7'></span>";
        "format-disconnected" = "";
        "on-click" = "mpc --quiet toggle";
        "on-click-right" = "mpc update; mpc ls | mpc add";
        "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
        "on-scroll-up" = "mpc --quiet prev";
        "on-scroll-down" = "mpc --quiet next";
        "smooth-scrolling-threshold" = 5;
        "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
      };

      "custom/cava" = {
        "exec" = "sleep 1 && cava -p ${./cava/config.conf} | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'";
        "tooltip" = false;

        # "ccava_config" = ./cava/config.conf;
        # "framerate" = 30;

        # "autosens" = 1;
        # "overshoot" = 20;

        # "sensitivity" = 100;

        # "bars" = 12;
        # "lower_cutoff_freq" = 50;
        # "higher_cutoff_freq" = 10000;
        # "method" = "pulse";
        # "source" = "auto";
        # "stereo" = true;
        # "reverse" = false;
        # "bar_delimiter" = 0;
        # "monstercat" = false;
        # "waves" = false;
        # "noise_reduction" = 0.77;
        # "input_delay" = 2;
        # "format-icons" = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        # "actions" = {
        #   "on-click-right" = "mode";
        #};
      };

      "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "{icon} {volume}%";
        "format-muted" = "󰖁 Muted";
        "format-icons" = {
          "default" = [ "" "" "" ];
        };
        "on-click" = "pamixer -t";
        "tooltip" = false;
      };
      "backlight" = {
        "device" = "intel_backlight";
        "format" = "{icon} {percent}%";
        "format-icons" = [ "󰃝" "󰃞" "󰃟" "󰃠" ];
      };
      "battery" = {
        "interval" = 10;
        "states" = {
          "warning" = 20;
          "critical" = 10;
        };
        "format" = "{icon} {capacity}%";
        "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        "format-full" = "{icon} {capacity}%";
        "format-charging" = "󰂄 {capacity}%";
        "tooltip" = false;
      };
      "clock" = {
        "interval" = 1;
        "format" = "{:%H:%M    %p %A %d %b}";
        "tooltip" = true;
      };
      "memory" = {
        "interval" = 1;
        "format" = "󰍛 {percentage}%";
        "states" = {
          "warning" = 85;
        };
      };
      "cpu" = {
        "interval" = 1;
        "format" = "󰻠 {usage}%";
      };

      "custom/powermenu" = {
        "format" = "";
        "on-click" = "pkill rofi || ${rofiScript.powermenu}";
        "tooltip" = false;
      };
    };
  };
  style = ''
           * {
             font-family: "JetBrainsMono Nerd Font";
             font-size: 12pt;
             font-weight: bold;
             border-radius: 0px;
             transition-property: background-color;
             transition-duration: 0.5s;
           }
           @keyframes blink_red {
             to {
               background-color: rgb(242, 143, 173);
               color: rgb(26, 24, 38);
             }
           }
           .warning, .critical, .urgent {
             animation-name: blink_red;
             animation-duration: 1s;
             animation-timing-function: linear;
             animation-iteration-count: infinite;
             animation-direction: alternate;
           }
           window#waybar {
             background-color: transparent;
           }
           window > box {
             margin-left: 5px;
             margin-right: 5px;
             margin-top: 5px;
             background-color: rgb(30, 30, 46);
           }
     #workspaces {
             padding-left: 0px;
             padding-right: 4px;
           }
     #workspaces button {
             padding-top: 5px;
             padding-bottom: 5px;
             padding-left: 6px;
             padding-right: 6px;
           }
     #workspaces button.active {
             background-color: rgb(181, 232, 224);
             color: rgb(26, 24, 38);
           }
     #workspaces button.urgent {
             color: rgb(26, 24, 38);
           }
     #workspaces button:hover {
             background-color: rgb(248, 189, 150);
             color: rgb(26, 24, 38);
           }
           tooltip {
             background: rgb(48, 45, 65);
           }
           tooltip label {
             color: rgb(217, 224, 238);
           }
     #custom-launcher {
             font-size: 20px;
             padding-left: 8px;
             padding-right: 6px;
             color: #7ebae4;
           }
     #mode, #clock, #memory, #temperature,#cpu,#mpd, #custom-wall, #temperature, #backlight, #pulseaudio, #network, #battery, #custom-powermenu, #custom-cava {
             padding-left: 10px;
             padding-right: 10px;
           }
           /* #mode { */
           /* 	margin-left: 10px; */
           /* 	background-color: rgb(248, 189, 150); */
           /*     color: rgb(26, 24, 38); */
           /* } */
     #memory {
             color: rgb(181, 232, 224);
           }
     #cpu {
             color: rgb(245, 194, 231);
           }
     #clock {
             color: rgb(217, 224, 238);
           }
    /* #idle_inhibitor {
             color: rgb(221, 182, 242);
           }*/
     #custom-wall {
             color: rgb(221, 182, 242);
        }
     #temperature {
             color: rgb(150, 205, 251);
           }
     #backlight {
             color: rgb(248, 189, 150);
           }
     #pulseaudio {
             color: rgb(245, 224, 220);
           }
     #network {
             color: #ABE9B3;
           }

     #network.disconnected {
             color: rgb(255, 255, 255);
           }
     #battery.charging, #battery.full, #battery.discharging {
             color: rgb(250, 227, 176);
           }
     #battery.critical:not(.charging) {
             color: rgb(242, 143, 173);
           }
     #custom-powermenu {
             color: rgb(242, 143, 173);
           }
     #tray {
             padding-right: 8px;
             padding-left: 10px;
           }
     #mpd.paused {
             color: #414868;
             font-style: italic;
           }
     #mpd.stopped {
             background: transparent;
           }
     #mpd {
             color: #c0caf5;
           }
     #custom-cava{
             font-family: "Hack Nerd Font" ;
           }
  '';
in
{
  enable = true;
  systemd = {
    enable = false;
    target = "graphical-session.target";
  };
  inherit settings style;
}
