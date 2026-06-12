{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [ ];
}
