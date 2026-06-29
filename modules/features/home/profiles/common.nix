{ self, ... }:

{
  flake.nixosModules.homeCommon = { ... }:
    {
      imports = [
        self.nixosModules.homeShared
        self.nixosModules.homeBat
        self.nixosModules.homeBtop
        self.nixosModules.homeEza
        self.nixosModules.homeFastfetch
        self.nixosModules.homeFzf
        self.nixosModules.homeGit
        self.nixosModules.homeKitty
        self.nixosModules.homeVim
        self.nixosModules.homeZsh
      ];
    };
}
