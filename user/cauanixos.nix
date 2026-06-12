{ config, pkgs, ... }:

{
  users.users.cauanixos = {
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "podman"
    ];

    packages = with pkgs; [ ];

    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    micro
  ];

  programs.zsh.enable = true;
}
