{ config, pkgs, ... }:

{
  boot.kernelParams = [
    "amd_pstate=disable"
  ];
}
