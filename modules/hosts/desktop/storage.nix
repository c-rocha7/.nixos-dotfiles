{ ... }:

{
  flake.nixosModules.desktopStorage = { ... }:
    {
      boot.supportedFilesystems = [ "ntfs" ];

      zramSwap = {
        algorithm = "zstd";
        enable = true;
        memoryMax = 8192 * 1024 * 1024;
        priority = 100;
      };

      fileSystems."/home/cauanixos/Discos/SSD 480 GB" = {
        device = "/dev/disk/by-uuid/A69ABEBC9ABE8877";
        fsType = "ntfs3";
        options = [ "defaults" "uid=1000" "gid=100" "nofail" "windows_names" ];
      };

      fileSystems."/home/cauanixos/Discos/SSD 512 GB" = {
        device = "/dev/disk/by-uuid/FC88C6D388C68C18";
        fsType = "ntfs3";
        options = [ "defaults" "uid=1000" "gid=100" "nofail" "windows_names" ];
      };

      fileSystems."/home/cauanixos/Discos/HD 1 TB" = {
        device = "/dev/disk/by-uuid/A488AEB388AE8380";
        fsType = "ntfs3";
        options = [ "defaults" "uid=1000" "gid=100" "nofail" "windows_names" ];
      };
    };
}
