{
  description = "Minha configuração NixOS com Flakes e Home-Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-flatpak, ... }@inputs:
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
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system; 
        specialArgs = { inherit inputs; }; 
        
        modules = [
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
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
              "${nixpkgs-unstable}/nixos/modules/programs/obs-studio.nix"
              "${nixpkgs-unstable}/nixos/modules/services/display-managers/ly.nix"
              "${nixpkgs-unstable}/nixos/modules/programs/steam.nix"
              "${nixpkgs-unstable}/nixos/modules/virtualisation/docker.nix"
              "${nixpkgs-unstable}/nixos/modules/virtualisation/waydroid.nix"
            ];

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.cauanixos = import ./home.nix;
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };
    };
}
