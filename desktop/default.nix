{ config, pkgs, ... }:

{
  imports = [
    ./audio-pipewire.nix
    # ./dm-gdm.nix
    ./dm-sddm.nix
    ./fonts.nix
    ./printing.nix
    ./teclado-br.nix
    ./upower.nix
    # ./wm-gnome.nix
    ./wm-plasma6.nix
  ];
}
