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
in
{
  imports = [
    ./config/git.nix
  ];

  home = {
    username = "cauanixos";
    homeDirectory = "/home/cauanixos";
    stateVersion = "25.11";

    packages = (with pkgs; [
      tree 
      grandLineAdventures 
    ]) ++ (with pkgs.unstable; [
      heroic protonplus obsidian spotify vscode 
      vesktop mpv microsoft-edge mullvad-browser 
      chromium yazi google-chrome zed-editor 
      onlyoffice-desktopeditors qutebrowser 
      spotify-player zsh-powerlevel10k 
      gnome-boxes kitty
    ]);

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
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      # Carrega o tema Powerlevel10k configurado via plugins
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      
      # Carrega sua configuração personalizada do p10k
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}
