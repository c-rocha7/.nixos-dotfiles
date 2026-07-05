{ ... }:

{
  flake.nixosModules.onlyofficeDesktopeditors = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          onlyoffice-desktopeditors
        ];
      };
    };
}
