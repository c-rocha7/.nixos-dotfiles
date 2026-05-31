{ config, pkgs, ... }:

{
    boot.supportedFilesystems = [ "ntfs" ];

    boot.loader = 
    {
        systemd-boot.enable = false;

        efi.canTouchEfiVariables = true;

        grub = 
        {
            enable = true;
            device = "nodev";
            efiSupport = true;
            efiInstallAsRemovable = false;
            useOSProber = false;
            configurationLimit = 10;
        };
    };
}
