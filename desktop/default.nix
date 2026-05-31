{ config, pkgs, ... }:

{
    imports = 
    [
        ./audio-pipewire.nix
        ./printing.nix
        ./upower.nix
        ./teclado-br.nix
        ./dm-sddm.nix
        ./wm-plasma6.nix
    ];
}
