{ ... }:

{
  flake.nixosModules.pavucontrol = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          pavucontrol
        ];
      };
    };
}
