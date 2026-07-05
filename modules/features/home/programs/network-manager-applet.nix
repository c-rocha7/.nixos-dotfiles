{ ... }:

{
  flake.nixosModules.networkManagerApplet = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          networkmanagerapplet
        ];
      };
    };
}
