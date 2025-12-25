{ config, pkgs, inputs, ... }:

let
  grandLineAdventures = pkgs.makeDesktopItem {
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
  };

  workAndDev = with pkgs; [
    filezilla
    tree
  ];

  browsers = with pkgs.unstable; [
    microsoft-edge
    google-chrome
    mullvad-browser
  ];

  mediaAndSocial = with pkgs.unstable; [
    spotify
    vesktop
    mpv
    obsidian
  ];

  editorsAndTools = with pkgs.unstable; [
    vscode
    onlyoffice-desktopeditors
  ];

  gamingTools = with pkgs.unstable; [
    heroic
    protonplus
  ];

  desktopTools = with pkgs.unstable; [
    kitty
  ];

in
{
  imports = [
    ./modules/git.nix
  ];

  home = {
    username = "cauanixos";
    homeDirectory = "/home/cauanixos";
    stateVersion = "25.11";

    packages = workAndDev
      ++ browsers
      ++ mediaAndSocial
      ++ editorsAndTools
      ++ gamingTools
      ++ desktopTools
      ++ [ grandLineAdventures ];
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    shellAliases = {
      ll = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
      ff = "fastfetch";
      la = "ls -a";
    };
  };
}
