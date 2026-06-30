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
      self.nixosModules.nixLd

      self.nixosModules.desktopConfiguration
      self.nixosModules.desktopStorage

      self.nixosModules.home
      self.nixosModules.bat
      self.nixosModules.browsers
      self.nixosModules.dev
      self.nixosModules.eza
      self.nixosModules.fzf
      self.nixosModules.glaDesktopItem
      self.nixosModules.heroic
      self.nixosModules.obsidian
      self.nixosModules.spotifyPlayer
      self.nixosModules.vesktop
      self.nixosModules.zsh

      self.nixosModules.btop
      self.nixosModules.cava
      self.nixosModules.fastfetch
      self.nixosModules.kitty
    ];
  };
}
