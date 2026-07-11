{ self, inputs, ... }:

{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.nix-flatpak.nixosModules.nix-flatpak
      inputs.stylix.nixosModules.stylix

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

      /*--- Desktop ---*/
      self.nixosModules.desktopConfiguration
      self.nixosModules.desktopStorage

      /*--- Home ---*/
      self.nixosModules.home

      /*--- Programs ---*/
      self.nixosModules.arj
      self.nixosModules.bat
      self.nixosModules.browsers
      self.nixosModules.dev
      self.nixosModules.eza
      self.nixosModules.fzf
      self.nixosModules.glaDesktopItem
      self.nixosModules.heroic
      self.nixosModules.networkManagerApplet
      self.nixosModules.nil
      self.nixosModules.nixd
      self.nixosModules.nixpkgsFmt
      self.nixosModules.obsidian
      self.nixosModules.onlyofficeDesktopeditors
      self.nixosModules.p7zip
      self.nixosModules.pavucontrol
      self.nixosModules.qview
      self.nixosModules.spotifyPlayer
      self.nixosModules.unrar
      self.nixosModules.unzip
      self.nixosModules.vesktop
      self.nixosModules.zip
      self.nixosModules.zsh

      /*--- Wrappers Modules NixOS ---*/
      self.nixosModules.nixosSteam
      self.nixosModules.nixLd

      /*--- Wrappers Modules Home ---*/
      self.nixosModules.btop
      self.nixosModules.cava
      self.nixosModules.fastfetch
      self.nixosModules.hyprlock
      self.nixosModules.kitty
      self.nixosModules.mpv
      self.nixosModules.rofi
      self.nixosModules.waybar
      self.nixosModules.yazi
    ];
  };
}
