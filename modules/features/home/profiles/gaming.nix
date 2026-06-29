{ self, ... }:

{
  flake.nixosModules.homeGaming = { ... }:
    {
      imports = [
        self.nixosModules.homeHeroic
      ];
    };
}
