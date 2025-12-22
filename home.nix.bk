{ config, pkgs, ... }:

{
  imports = [
    ./config/git.nix
  ];
  home.username = "cauanixos";
  home.homeDirectory = "/home/cauanixos";

  home.packages = with pkgs; [
    tree
    unstable.heroic
    unstable.protonplus
    unstable.obsidian
    unstable.spotify
    unstable.vscode
    unstable.vesktop
    unstable.mpv
    unstable.microsoft-edge
    unstable.mullvad-browser
    unstable.chromium
    unstable.yazi
    unstable.google-chrome
    unstable.zed-editor
    unstable.onlyoffice-desktopeditors
    unstable.qutebrowser
    unstable.spotify-player
    unstable.zsh-powerlevel10k
    kitty

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

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
      ff = "fastfetch";
      la = "ls -a";
    };
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      # Carrega o seu p10k.zsh (agora gerenciado pelo Home Manager)
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    enableCompletion = true;
  };

  home.file.".p10k.zsh".source = ./config/p10k.zsh;

  home.stateVersion = "25.11";
}
