{ ... }:

{
  flake.nixosModules.unzip = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home-packages = with pkgs; [
          unzip
        ];
      };
    };
}
