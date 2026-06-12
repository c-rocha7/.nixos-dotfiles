{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./amd
    ./bootloaders
    ./desktop
    ./flatpak
    ./hardware-configuration.nix
    ./kernel-params
    ./network
    ./nix-settings
    ./user
    ./zram
  ];

  system.stateVersion = "26.05";
}
