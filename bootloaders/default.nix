{ config, pkgs, ... }:

{
  imports = [
    # ./grub.nix
    # ./systemd-boot.nix
    ./limine.nix
  ];
}
