{ self, inputs, ... }:

{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.nix-flatpak.nixosModules.nix-flatpak
      self.nixosModules.desktopConfiguration
      self.nixosModules.sharedHome
      self.nixosModules.homeGit
      self.nixosModules.homeTerminal
      self.nixosModules.homeBrowser
    ];
  };
}
