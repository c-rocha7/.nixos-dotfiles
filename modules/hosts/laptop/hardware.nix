{ self, inputs, ... }: {

  flake.nixosModules.laptopHardware = { config, lib, pkgs, modulesPath, ... }:
    {
        imports =
            [ (modulesPath + "/installer/scan/not-detected.nix")
            ];

        boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];

        fileSystems."/" =
            { device = "/dev/disk/by-uuid/12663da0-91a8-462c-94b4-2681fe3157eb";
            fsType = "ext4";
            };

        fileSystems."/boot" =
            { device = "/dev/disk/by-uuid/846B-6EA2";
            fsType = "vfat";
            options = [ "fmask=0077" "dmask=0077" ];
            };

        swapDevices = [ ];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}