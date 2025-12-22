{ pkgs, ... }:

{
  users.users.cauanixos = {
    isNormalUser = true;
    description = "cauanixos";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "video" "audio" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  security.polkit.enable = true;
}
