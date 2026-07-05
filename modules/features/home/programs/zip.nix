{ ... }:

{
  flake.nixosModules.zip = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          zip
        ];
      };
    };
}
