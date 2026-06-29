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

      self.nixosModules.nixosBase
      self.nixosModules.nixosDesktop
      self.nixosModules.nixosSteam
      self.nixosModules.nixosUserCauanixos

      self.nixosModules.desktopIdentity
      self.nixosModules.desktopConfiguration
      self.nixosModules.desktopStorage

      self.nixosModules.homeCommon
      self.nixosModules.homeDev
      self.nixosModules.homeDesktopApps
      self.nixosModules.homeGaming
    ];
  };
}
