{
    description = "Minha configuração NixOS com Flakes e Home-Manager";

    inputs = 
    {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

        lanzaboote = {
            url = "github:nix-community/lanzaboote/v1.0.0";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = 
        {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        zen-browser = 
        {
            url = "github:youwen5/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-flatpak.url = "github:gmodena/nix-flatpak";
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, lanzaboote, home-manager, nix-flatpak, ...}@inputs:
    let
        system = "x86_64-linux";

        unstableOverlay = final: prev: 
        {
            unstable = import nixpkgs-unstable 
            {
                inherit system;
                config.allowUnfree = true;
            };
        };
    in
    {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem 
        {
            inherit system;
            specialArgs = { inherit inputs; };

            modules = 
            [
                ./configuration.nix
                nix-flatpak.nixosModules.nix-flatpak
                home-manager.nixosModules.home-manager
                lanzaboote.nixosModules.lanzaboote

                {
                    nixpkgs.overlays = [ unstableOverlay ];

                    home-manager = 
                    {
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
