{ config, pkgs, ... }:

{
    imports = 
    [
        ./secure-boot.nix
    ];
}
