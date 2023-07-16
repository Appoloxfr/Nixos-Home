let
  settings = {
    ignore-errors = true;
    live-from-start = true;

    # Remove spaces
    restrict-filenames = true;

    output = "~/Videos/Youtube/%(title)s.%(ext)s";

    # When using -x to extract audio
    audio-format = "best";
    audio-quality = 7;
  };
in
{
  enable = true;
  inherit settings;
}
