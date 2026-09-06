{ ... }:

{
  flake.nixosModules.nil = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          nil
        ];
      };
    };
}
