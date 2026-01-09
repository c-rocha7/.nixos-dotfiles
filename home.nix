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
    asdf-vm
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
    ./modules/fastfetch
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

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };
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

    history = {
      save = 0;
      size = 1000;
      path = "/dev/null";
    };

    history.share = false;

    initContent = ''
      export HISTFILE=/dev/null
      . ${pkgs.asdf-vm}/share/asdf-vm/asdf.sh
    '';

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      ls = "eza --icons";
      ll = "ls -la";
      la = "ls -a";
      bat = "bat --style=auto";
      ff = "fastfetch";
      sail = "sh $([ -f sail ] && echo sail || echo vendor/bin/sail)";
      doc = "cd ~/Documentos";
      obsidian = "cd ~/Documentos/Obsidian\ Notes/";
      nix-init = "f(){ nix flake init --template \"https://flakehub.com/f/the-nix-way/dev-templates/*#$1\" && echo \"use flake\" > .envrc && direnv allow; unset -f f; }; f";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];
  };
}
