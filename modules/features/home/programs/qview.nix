{ ... }:

{
  flake.nixosModules.qview = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          qview
        ];
      };
    };
}
