{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernelParams = [
    "kernel.split_lock_mitigate=0"
  ];
}
