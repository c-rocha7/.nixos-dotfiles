{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./kernel-params
    ./amd
    ./zram
    ./bootloaders
    ./network
    ./desktop
    ./flatpak
    ./nix-settings
    ./user
  ];

  # Versão do sistema
  system.stateVersion = "25.11";
}
