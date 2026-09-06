{ ... }:

{
  flake.nixosModules.nixpkgsFmt = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          nixpkgs-fmt
        ];
      };
    };
}
