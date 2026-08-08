{ ... }:

{
  flake.nixosModules.distrobox = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          podman
        ];

        programs.distrobox = {
          enable = true;
        };
      };
    };
}
