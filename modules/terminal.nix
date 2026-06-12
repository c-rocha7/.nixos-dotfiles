{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
    fastfetch
    pkgs.unstable.btop
    pkgs.unstable.bat
    pkgs.unstable.eza
  ];
}
