{ self, inputs, ... }:

{
  flake.nixosModules.cava = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        programs.cava = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.myCava;
        };
      };
    };

  perSystem = { pkgs, ... }:
    {
      packages.myCava = inputs.wrapper-modules.wrappers.cava.wrap {
        inherit pkgs;
      };
    };
}
