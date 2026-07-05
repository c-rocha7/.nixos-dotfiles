{ ... }:

{
  flake.nixosModules.unrar = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          unrar
        ];
      };
    };
}
