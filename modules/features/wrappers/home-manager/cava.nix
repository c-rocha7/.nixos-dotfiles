{ self, inputs, ... }:

{
  flake.nixosModules.cava = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
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
