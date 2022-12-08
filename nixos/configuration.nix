{ pkgs, ... }:


{
  imports = [
    ./hardware-configuration.nix
  ];

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "vim";
      VISUAL = "vim";
    };

    systemPackages = with pkgs; [
      docker-client
      docker-compose
      arion
      blueman
    ];
    shells = [ pkgs.fish ];
  };

  virtualisation = {
    docker = {
      enable = true;
      rootless.enable = true;
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings.substituters = [
      # Epita cache
      "https://s3.cri.epita.fr/cri-nix-cache.s3.cri.epita.fr"
      # Other cache website
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];

    gc = {
      automatic = true;
      dates = "monthly";
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    initrd.secrets = { "/crypto_keyfile.bin" = null; };
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 1;
    };
  };

  users.users.gabriel = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = false;
  };

  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      displayManager = { defaultSession = "xfce+i3"; };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu # default i3 dmenu, won't boot without
          i3lock # default i3 screen locker
          i3-gaps
          rofi # upgrade of dmenu
        ];
        package = pkgs.i3-gaps;
      };


      layout = "us";
      xkbVariant = "";
      xkbOptions = "caps:swapescape";
      autoRepeatDelay = 220;
      autoRepeatInterval = 35;
    };

    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  };

  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.utf8";
      LC_IDENTIFICATION = "fr_FR.utf8";
      LC_MEASUREMENT = "fr_FR.utf8";
      LC_MONETARY = "fr_FR.utf8";
      LC_NAME = "fr_FR.utf8";
      LC_NUMERIC = "fr_FR.utf8";
      LC_PAPER = "fr_FR.utf8";
      LC_TELEPHONE = "fr_FR.utf8";
      LC_TIME = "fr_FR.utf8";
    };
  };

  sound.enable = true;

  security.rtkit.enable = true;

  system.stateVersion = "22.05";
}
