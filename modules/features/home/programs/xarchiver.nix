{ ... }:

{
  flake.nixosModules.xarchiver = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          xarchiver
        ];
      };
    };
}
