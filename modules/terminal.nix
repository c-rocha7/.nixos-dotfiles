{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
    fastfetch
    pkgs.unstable.btop
  ];
}
