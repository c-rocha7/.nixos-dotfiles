{ ... }:

{
  flake.nixosModules.p7zip = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          p7zip
        ];
      };
    };
}
