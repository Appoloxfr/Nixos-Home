{
  description = "My nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };


  outputs = { self, nixpkgs, flake-utils, home-manager, hyprland, ... }:
    let
      username = "gabriel";
      hostname = "nixos";
      homeDirectory = "/home/${username}";
      system = "x86_64-linux";
      stateVersion = "22.11";

      pkgs = import nixpkgs
        {
          inherit system;
          config = {
            allowUnfree = true;
            xdg = {
              configHome = homeDirectory;
            };
          };
        };

      inherit (flake-utils.lib) eachDefaultSystem;
    in
    {
      homeConfigurations = {
        default = username;
        "${username}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            hyprland.homeManagerModules.default
            { wayland.windowManager.hyprland.enable = true; }
            (import ./home {
              inherit pkgs system stateVersion username homeDirectory;
            })
          ];
        };
      };
      nixosConfigurations = {
        default = hostname;
        ${hostname} = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/configuration.nix
            hyprland.nixosModules.default
            { programs.hyprland.enable = true; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
      };
    };
}
