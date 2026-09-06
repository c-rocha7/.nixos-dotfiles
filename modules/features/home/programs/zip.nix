{ ... }:

{
  flake.nixosModules.zip = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          zip
        ];
      };
    };
}
