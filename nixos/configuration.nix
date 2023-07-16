{ pkgs, ... }:


{
  imports = [
    ./hardware-configuration.nix
  ];

  environment = {
    variables = {
      BROWSER = "firefox";
      EDITOR = "vim";
      TERM = "kitty";
      TERMINAL = "kitty";
      VISUAL = "vim";
    };

    systemPackages = with pkgs; [
      docker-client
      docker-compose
      arion
      blueman
      pavucontrol

      libnotify
      wl-clipboard
      wlr-randr
      wayland
      wayland-scanner
      wayland-utils
      egl-wayland
      wayland-protocols
      pkgs.xorg.xeyes
      glfw-wayland
      xwayland
      pkgs.qt6.qtwayland
      cinnamon.nemo
      networkmanagerapplet
      wev
      wf-recorder
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      linux-firmware
      sshpass
      lxappearance
      imagemagick
      pkgs.sway-contrib.grimshot
      flameshot
      grim
      xdg-utils

      swayidle
      swaylock-effects

      swww
    ];
  };

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings = {
      substituters = [
        # Epita cache
        "https://s3.cri.epita.fr/cri-nix-cache.s3.cri.epita.fr"
        # Hyprland cache
        "https://hyprland.cachix.org"
        # Other cache website
        "https://cache.nixos.org/"
      ];

      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    gc.automatic = false;
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
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.fish;
  };
  programs = {
    fish.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    light.enable = true;
  };

  fonts = {
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = false;
  };

  xdg.portal = {
    enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    xserver = {
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
      jack.enable = true;
      wireplumber.enable = true;
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

  # Conflit with pipewire
  sound.enable = false;

  security.rtkit.enable = true;
  security.pam.services.swaylock = { };

  system.stateVersion = "22.05";
}
