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

  mediaAndSocialStable = with pkgs; [
    vesktop
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
      ++ mediaAndSocialStable
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

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };

    shellAliases = {
      ls = "eza --icons";
      bat = "bat --style=auto";
      ll = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
      ff = "fastfetch";
      la = "ls -a";
      sail = "sh $([ -f sail ] && echo sail || echo vendor/bin/sail)";
    };
  };
}
