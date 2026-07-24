{ ... }:

{
  flake.nixosModules.laptopHardware = { config, lib, modulesPath, ... }:
    {
      imports =
        [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];

      boot.initrd.availableKernelModules =
        [
          "nvme"
          "xhci_pci"
          "usb_storage"
          "sd_mod"
        ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" =
        {
          device = "/dev/disk/by-uuid/857956e2-b38d-4035-9768-4dabb598bda9";
          fsType = "ext4";
          options =
            [
              "noatime"
              "nodiratime"
            ];
        };

      fileSystems."/boot" =
        {
          device = "/dev/disk/by-uuid/9164-58C1";
          fsType = "vfat";
          options =
            [
              "fmask=0077"
              "dmask=0077"
            ];
        };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
