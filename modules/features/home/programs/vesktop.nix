{ ... }:

{
  flake.nixosModules.homeVesktop = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        programs.vesktop = {
          enable = true;
          package = pkgs.unstable.vesktop;
        };
      };
    };
}
