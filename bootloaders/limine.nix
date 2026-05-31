{ config, pkgs, ... }:

{
    boot.supportedFilesystems = [ "ntfs" ];

    boot.loader = 
    {
        systemd-boot.enable = false;
        grub.enable = false;
        efi.canTouchEfiVariables = true;

        limine = 
        {
            enable = true;
            maxGenerations = 10;
        };
    };
}
