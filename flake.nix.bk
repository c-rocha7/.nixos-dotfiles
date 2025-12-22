{
  description = "Minha configuração NixOS com Flakes e Home-Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, zen-browser, ... }@inputs: 
  let
    system = "x86_64-linux";
    unstableOverlay = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = system;
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ unstableOverlay ];
            disabledModules = [
              "programs/obs-studio.nix"
              "programs/steam.nix"
              "services/display-managers/ly.nix"
              "virtualisation/docker.nix"
              "virtualisation/waydroid.nix"
            ];
            imports = [
              "${inputs.nixpkgs-unstable}/nixos/modules/programs/obs-studio.nix"
              "${inputs.nixpkgs-unstable}/nixos/modules/services/display-managers/ly.nix"
              "${inputs.nixpkgs-unstable}/nixos/modules/programs/steam.nix"
              "${inputs.nixpkgs-unstable}/nixos/modules/virtualisation/docker.nix"
              "${inputs.nixpkgs-unstable}/nixos/modules/virtualisation/waydroid.nix"
            ];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.cauanixos = import ./home.nix;
            };
          }
        ];
      };
    };
  };
}
