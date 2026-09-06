{ ... }:

{
  flake.nixosModules.onlyofficeDesktopeditors = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          onlyoffice-desktopeditors
        ];
      };
    };
}
