{
  description = "My nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, flake-utils, home-manager, ... }:
    let
      username = "gabriel";
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
            (import ./home {
              inherit pkgs system stateVersion username homeDirectory;
            })
          ];
        };
      };
    };
}
