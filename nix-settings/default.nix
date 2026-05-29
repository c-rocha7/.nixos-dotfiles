{ config, pkgs, ... }:

{
  imports = [
    ./nix-settings.nix
    ./kvm.nix
    ./podman.nix
  ];
}
