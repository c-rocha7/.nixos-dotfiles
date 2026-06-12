{ config, pkgs, ... }:

{
  imports = [
    # ./grub.nix
    ./limine.nix
    # ./secure-boot.nix
    # ./systemd-boot.nix
  ];
}
