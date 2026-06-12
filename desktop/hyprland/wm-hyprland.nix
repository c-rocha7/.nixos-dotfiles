{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "breeze";
  };
}
