{ ... }:

{
  flake.nixosModules.distrobox = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          podman
        ];

        programs.distrobox = {
          enable = true;
        };
      };
    };
}
