let
  backgroundColor = "#1a1b26";
  borderColor = "#c0caf5";
  borderRadius = 3;
  borderSize = 3;
  defaultTimeout = 5 * 1000;
  extraConfig = ''
    text-alignment=center
    [urgency=high]
    border-color=#F8BD96
  '';
  font = "Iosevka Nerd Font 12";
  height = 500;
  margin = "10";
  padding = "5";
  progressColor = "over #302D41";
  textColor = "#c0caf5";
  width = 256;
in
{
  enable = true;
  inherit backgroundColor borderColor borderRadius borderSize defaultTimeout extraConfig font height margin padding progressColor textColor width;
}
