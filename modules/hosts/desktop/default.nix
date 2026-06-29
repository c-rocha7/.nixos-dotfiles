{ self, inputs, ... }:

{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.nix-flatpak.nixosModules.nix-flatpak

      self.nixosModules.desktopConfiguration
      self.nixosModules.desktopStorage

      self.nixosModules.homeShared
      self.nixosModules.homeBat
      self.nixosModules.homeBrowser
      self.nixosModules.homeBtop
      self.nixosModules.homeCava
      self.nixosModules.homeCode
      self.nixosModules.homeEza
      self.nixosModules.homeFastfetch
      self.nixosModules.homeFzf
      self.nixosModules.homeGit
      self.nixosModules.homeKitty
      self.nixosModules.homeObsidian
      self.nixosModules.homeZsh
    ];
  };
}
