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
          device = "/dev/disk/by-uuid/0002dd4f-2d18-4081-9b8b-d0a83fe04b52";
          fsType = "ext4";
          options =
            [
              "noatime"
              "nodiratime"
            ];
        };

      fileSystems."/boot" =
        {
          device = "/dev/disk/by-uuid/E54C-F94A";
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
