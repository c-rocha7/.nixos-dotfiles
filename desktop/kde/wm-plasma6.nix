{ config, pkgs, ... }:

{
  security.polkit.enable = true;
  services.desktopManager.plasma6.enable = true;
}
