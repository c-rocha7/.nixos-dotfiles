{ self, inputs, ... }:

{
  flake.nixosModules.desktopHardware = { config, lib, pkgs, modulesPath, ... }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
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

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/09a51123-1028-4f8f-9010-77d2166767e9";
        fsType = "ext4";
        options = [
          "noatime"
          "nodiratime"
        ];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/D7A6-265C";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
