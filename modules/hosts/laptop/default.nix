{ self, inputs, ... }:

{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
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

      /*--- Laptop ---*/
      self.nixosModules.laptopConfiguration

      /*--- Home ---*/
      self.nixosModules.home

      /*--- Programs ---*/
      self.nixosModules.bat
      self.nixosModules.browsers
      self.nixosModules.dev
      self.nixosModules.eza
      self.nixosModules.fzf
      self.nixosModules.distrobox
      self.nixosModules.nil
      self.nixosModules.nixd
      self.nixosModules.nixpkgsFmt
      self.nixosModules.obsidian
      self.nixosModules.onlyofficeDesktopeditors
      self.nixosModules.spotifyPlayer
      self.nixosModules.vesktop
      self.nixosModules.zsh

      /*--- Wrappers Modules NixOS ---*/
      self.nixosModules.nixLd

      /*--- Wrappers Modules Home ---*/
      self.nixosModules.btop
      self.nixosModules.cava
      self.nixosModules.fastfetch
      self.nixosModules.kitty
      self.nixosModules.mpv
      self.nixosModules.yazi
    ];
  };
}
