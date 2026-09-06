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
          device = "/dev/disk/by-uuid/39308001-f3e0-436d-b42b-6ef4257bb54d";
          fsType = "ext4";
          options =
            [
              "noatime"
              "nodiratime"
            ];
        };

      fileSystems."/boot" =
        {
          device = "/dev/disk/by-uuid/536F-3F92";
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
