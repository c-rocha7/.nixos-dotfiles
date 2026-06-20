{ config, pkgs, ... }:

{
  imports = [
    ./audio-pipewire.nix
    # ./gnome/dm-gdm.nix
    # ./gnome/wm-gnome.nix
    ./hyprland/dm-ly.nix
    # ./hyprland/wm-hyprland.nix
    # ./kde/dm-sddm.nix
    ./kde/wm-plasma6.nix
    ./fonts.nix
    ./printing.nix
    ./teclado-br.nix
    ./upower.nix
  ];
}
