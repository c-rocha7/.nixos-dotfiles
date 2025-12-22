{ config, lib, pkgs, ... }:

{
  # ========================================
  # Suporte a Sistemas de Arquivos
  # ========================================
  boot.supportedFilesystems = [ "ntfs" ];
  # ========================================
  # Montagem de Discos NTFS
  # ========================================
  fileSystems."/home/cauanixos/Jogos/ssd-512-gb" = {
    device = "/dev/disk/by-uuid/F002C0CA02C096CE";
    fsType = "ntfs3";
    options = [ "defaults" "uid=1000" "gid=100" "nofail" "windows_names" ];
  };

  fileSystems."/home/cauanixos/Jogos/hd-1-tb" = {
    device = "/dev/disk/by-uuid/2ED6CE36D6CDFDD9";
    fsType = "ntfs3";
    options = [ "defaults" "uid=1000" "gid=100" "nofail" "windows_names" ];
  };

  # ========================================
  # Otimização e Limpeza do Nix Store
  # ========================================
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
