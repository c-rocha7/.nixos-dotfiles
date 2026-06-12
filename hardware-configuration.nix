{ config, lib, pkgs, modulesPath, ... }:

{
    imports =
    [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules =
    [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
    {
        device = "/dev/disk/by-uuid/84b0b6de-544b-47c0-8a07-211aaff97a05";
        fsType = "ext4";
        options =
            [
                "noatime"
                "nodiratime"
            ];
    };

    fileSystems."/boot" =
    {
        device = "/dev/disk/by-uuid/CC74-E44C";
        fsType = "vfat";
        options =
            [
                "fmask=0022"
                "dmask=0022"
            ];
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
