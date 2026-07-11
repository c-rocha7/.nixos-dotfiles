{ self, inputs, ... }:

{
  flake.nixosModules.mpv = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        programs.mpv = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.myMpv;
        };
      };
    };

  perSystem = { pkgs, ... }:
    {
      packages.myMpv = inputs.wrapper-modules.wrappers.mpv.wrap {
        inherit pkgs;
      };
    };
}
