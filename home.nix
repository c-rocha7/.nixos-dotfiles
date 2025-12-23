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
    tree
  ];

  browsers = with pkgs.unstable; [
    microsoft-edge
    chromium
    google-chrome
    qutebrowser
    mullvad-browser
  ];

  mediaAndSocial = with pkgs.unstable; [
    spotify
    spotify-player
    vesktop
    mpv
    obsidian
  ];

  editorsAndTools = with pkgs.unstable; [
    vscode
    zed-editor
    onlyoffice-desktopeditors
    yazi
    kitty
    gnome-boxes
    filezilla
  ];

  gamingTools = with pkgs.unstable; [
    heroic
    protonplus
  ];

in
{
  imports = [
    ./config/git.nix
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
      ++ [ grandLineAdventures ];

    file.".p10k.zsh".source = ./config/p10k.zsh;
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
      nix-switch = "git add . && sudo nixos-rebuild switch --flake .";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}
