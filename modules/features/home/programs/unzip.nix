{ ... }:

{
  flake.nixosModules.unzip = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          unzip
        ];
      };
    };
}
