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

    gst_all_1.gstreamer
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly

    zip
    unzip
    p7zip
    unrar
    arj

    networkmanagerapplet

    mesa-demos
    vulkan-tools

    waybar
    swaynotificationcenter
    wlogout
    hyprshot
    waypaper
    awww
    wl-clipboard
    cliphist
    pavucontrol
    nwg-look
    kdePackages.polkit-kde-agent-1
    cpio

    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.ark
    kdePackages.kio-admin
    kdePackages.kde-cli-tools
    kdePackages.breeze
    kdePackages.breeze-icons

    papirus-icon-theme
  ];

  programs.zsh.enable = true;

  programs.gamemode.enable = true;
}
