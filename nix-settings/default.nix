{ config, pkgs, ... }:

{
    imports = 
    [
        ./kvm.nix
        ./nix-settings.nix
        ./podman.nix
    ];
}
