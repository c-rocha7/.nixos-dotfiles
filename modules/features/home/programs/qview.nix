{ ... }:

{
  flake.nixosModules.qview = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          qview
        ];
      };
    };
}
