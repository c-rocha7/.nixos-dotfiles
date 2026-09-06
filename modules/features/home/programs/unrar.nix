{ ... }:

{
  flake.nixosModules.unrar = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          unrar
        ];
      };
    };
}
