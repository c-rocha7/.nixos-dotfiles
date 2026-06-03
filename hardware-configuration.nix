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
            device = "/dev/disk/by-uuid/33bc2b51-4ed8-4f27-be27-06a037bb9d7a";
            fsType = "ext4";
            options = [ 
                "noatime"
                "nodiratime"
            ];
        };

    fileSystems."/boot" =
        { 
            device = "/dev/disk/by-uuid/91BA-8DF5";
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
