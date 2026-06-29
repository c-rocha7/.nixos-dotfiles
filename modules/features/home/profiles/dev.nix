{ self, ... }:

{
  flake.nixosModules.homeDev = { ... }:
    {
      imports = [
        self.nixosModules.homeCode
      ];
    };
}
