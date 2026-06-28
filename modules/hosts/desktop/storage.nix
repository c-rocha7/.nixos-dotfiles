{ self, inputs, ... }:

{
  flake.nixosModules.desktopStorage = { config, pkgs, lib, ... }:
    {
      boot.supportedFilesystems = [ "ntfs" ];

      zramSwap = {
        algorithm = "zstd";
        enable = true;
        memoryMax = 8192 * 1024 * 1024;
        priority = 100;
      };

      fileSystems."/home/cauanixos/Discos/ssd-480-gb" = {
        device = "/dev/disk/by-uuid/6832CA9232CA6522";
        fsType = "ntfs3";
        options = [ "defaults" "uid=1000" "gid=100" "nofail" "windows_names" ];
      };

      fileSystems."/home/cauanixos/Discos/ssd-512-gb" = {
        device = "/dev/disk/by-uuid/724CA77F4CA73CAB";
        fsType = "ntfs3";
        options = [ "defaults" "uid=1000" "gid=100" "nofail" "windows_names" ];
      };

      fileSystems."/home/cauanixos/Discos/hd-1-tb" = {
        device = "/dev/disk/by-uuid/402EC0132EC0043E";
        fsType = "ntfs3";
        options = [ "defaults" "uid=1000" "gid=100" "nofail" "windows_names" ];
      };
    };
}
