{ self, ... }:

{
  flake.nixosModules.homeDesktopApps = { ... }:
    {
      imports = [
        self.nixosModules.homeBrowser
        self.nixosModules.homeCava
        self.nixosModules.homeObsidian
        self.nixosModules.homeSpotifyPlayer
        self.nixosModules.homeVesktop
      ];
    };
}
