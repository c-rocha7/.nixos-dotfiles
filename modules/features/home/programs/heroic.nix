{ ... }:

{
  flake.nixosModules.heroic = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          unstable.heroic
        ];
      };
    };
}
