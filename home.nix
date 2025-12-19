{ config, pkgs, ... }:

{
  imports = [
    ./config/git.nix
  ];
  home.username = "cauanixos";
  home.homeDirectory = "/home/cauanixos";

  home.packages = with pkgs; [
    tree
    heroic
    protonplus
    obsidian
    spotify
    vscode
    vesktop
    mpv
    microsoft-edge
    mullvad-browser
    chromium
    yazi
    google-chrome
    zed-editor
    onlyoffice-desktopeditors
    qutebrowser
    spotify-player

    (makeDesktopItem {
      name = "grand-line-adventures";
      desktopName = "Grand Line Adventures";
      comment = "Grand Line Adventures";
      terminal = false;
      exec = "/home/cauanixos/\"Grand Line Adventures\"/glaclient-linux";
      icon = "/home/cauanixos/Grand Line Adventures/assets/glaclient.png";
      type = "Application";
      categories = [ "Game" ];
      keywords = [ "game" ];
      startupNotify = true;
      startupWMClass = "glaclient-linux";
    })
  ];

  home.stateVersion = "25.11";
}
