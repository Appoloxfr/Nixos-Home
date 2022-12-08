let
  icons = "awesome6";
  theme = "modern";
  bars = {
    bottom = {
      blocks = [
        {
          block = "disk_space";
          path = "/";
          alias = "/";
          info_type = "available";
          unit = "GB";
          interval = 120;
          warning = 20.0;
          alert = 10.0;
        }
        {
          block = "memory";
          display_type = "memory";
          format_mem = "{mem_used_percents}";
          format_swap = "{swap_used_percents}";
          clickable = false;
        }
        {
          block = "cpu";
          interval = 1;
        }
        {
          block = "load";
          interval = 1;
          format = "{1m}";
        }
        {
          block = "backlight";
          device = "intel_backlight";
          cycle = [ 100 50 25 1 25 50 ];
        }
        {
          block = "sound";
          show_volume_when_muted = true;
          headphones_indicator = true;
        }
        {
          block = "net";
          interval = 5;
        }
        {
          block = "battery";
          interval = 30;
          driver = "upower";
        }
        {
          block = "time";
          interval = 60;
          format = "%a %R %d/%m";
        }
      ];
      settings = {
        theme.name = theme;
        icons.name = icons;
      };
      inherit icons theme;
    };
  };
in
{
  enable = true;
  inherit bars;
}
