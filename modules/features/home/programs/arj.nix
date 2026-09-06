{ ... }:

{
  flake.nixosModules.arj = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          arj
        ];
      };
    };
}
