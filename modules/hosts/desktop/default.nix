{ self, inputs, ... }:

{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.nix-flatpak.nixosModules.nix-flatpak

      ({ ... }: {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = import inputs.nixpkgs-unstable {
              system = prev.stdenv.hostPlatform.system;
              config.allowUnfree = true;
            };
          })
        ];
      })

      self.nixosModules.nixosSteam

      self.nixosModules.desktopConfiguration
      self.nixosModules.desktopStorage

      self.nixosModules.homeShared
      self.nixosModules.homeBat
      self.nixosModules.homeBrowser
      self.nixosModules.homeCode
      self.nixosModules.homeEza
      self.nixosModules.homeFzf
      self.nixosModules.homeHeroic
      self.nixosModules.homeObsidian
      self.nixosModules.homeSpotifyPlayer
      self.nixosModules.homeVesktop
      self.nixosModules.homeZsh

      self.nixosModules.btop
      self.nixosModules.cava
      self.nixosModules.fastfetch
      self.nixosModules.kitty
    ];
  };
}
