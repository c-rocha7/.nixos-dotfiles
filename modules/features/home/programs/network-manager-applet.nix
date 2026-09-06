{ ... }:

{
  flake.nixosModules.networkManagerApplet = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          networkmanagerapplet
        ];
      };
    };
}
