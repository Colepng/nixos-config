{
  description = "System configuration flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixos-hardware,
      rust-overlay,
      stylix,
      spicetify-nix,
      caelestia-shell,
      nix-flatpak,
      ...
    }:
    {
      nixosConfigurations = {
        lenovo = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit rust-overlay;
            inherit inputs;
          };
          modules = [
            ./machine/lenovo
            ./machine/common

            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            spicetify-nix.nixosModules.spicetify
            nix-flatpak.nixosModules.nix-flatpak
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit caelestia-shell;
              };

              home-manager.users.cole.imports = [
                ./home-manager/common
                ./home-manager/lenovo
                caelestia-shell.homeManagerModules.default
              ];
            }

            nixos-hardware.nixosModules.lenovo-legion-16achg6-hybrid
          ];
        };
        framework = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit rust-overlay;
            inherit inputs;
          };
          modules = [
            ./machine/framework
            ./machine/common

            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            spicetify-nix.nixosModules.spicetify
            nix-flatpak.nixosModules.nix-flatpak
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit caelestia-shell;
                inherit inputs;
              };

              home-manager.users.cole.imports = [
                ./home-manager/common
                ./home-manager/framework
                inputs.niri.homeModules.niri
                inputs.dms.homeModules.dank-material-shell
                inputs.dms.homeModules.niri
                caelestia-shell.homeManagerModules.default
              ];
            }

            nixos-hardware.nixosModules.framework-12-13th-gen-intel
          ];
        };
      };
    };
}
