let
  icons = "material-nf";
  theme = "modern";
  bars = {
    bottom = {
      blocks = [
        {
          alert = 10.0;
          alert_unit = "GB";
          block = "disk_space";
          info_type = "available";
          interval = 120;
          path = "/";
          warning = 20.0;
        }
        {
          block = "memory";
          format = " $icon $mem_total_used_percents ";
        }
        {
          block = "cpu";
          interval = 1;
        }
        {
          block = "load";
          format = " $icon $1m ";
          interval = 1;
        }
        {
          block = "backlight";
          cycle = [ 100 50 25 1 25 50 ];
          device = "intel_backlight";
        }
        {
          block = "sound";
          headphones_indicator = true;
        }
        {
          block = "net";
          interval = 5;
        }
        {
          block = "battery";
          driver = "upower";
          interval = 30;
        }
        {
          block = "time";
          format = " $icon $timestamp.datetime(f:'%a %R %d/%m')";
          interval = 60;
        }
      ];
      settings = {
        icons.icons = icons;
        theme.theme = theme;
      };
      inherit icons theme;
    };
  };
in
{
  enable = true;
  inherit bars;
}
