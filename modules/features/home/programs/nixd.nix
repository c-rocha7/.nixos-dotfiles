{ ... }:

{
  flake.nixosModules.nixd = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          nixd
        ];
      };
    };
}
