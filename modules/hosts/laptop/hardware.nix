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
          device = "/dev/disk/by-uuid/19c08d74-1783-4171-98e3-62b87a219e27";
          fsType = "ext4";
          options =
            [
              "noatime"
              "nodiratime"
            ];
        };

      fileSystems."/boot" =
        {
          device = "/dev/disk/by-uuid/4BB2-5826";
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
