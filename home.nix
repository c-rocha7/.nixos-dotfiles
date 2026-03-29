{ config, pkgs, inputs, ... }:

let
  # grandLineAdventures = pkgs.makeDesktopItem {
  #   name = "grand-line-adventures";
  #   desktopName = "Grand Line Adventures";
  #   comment = "Grand Line Adventures";
  #   terminal = false;
  #   exec = "/home/cauanixos/\"Grand Line Adventures\"/glaclient-linux";
  #   icon = "/home/cauanixos/Grand Line Adventures/assets/glaclient.png";
  #   type = "Application";
  #   categories = [ "Game" ];
  #   keywords = [ "game" ];
  #   startupNotify = true;
  #   startupWMClass = "glaclient-linux";
  # };

  stablePkgs = with pkgs; [
    spotify
    mpv
    obsidian
    tree
    filezilla
  ];

  unstablePkgs = with pkgs.unstable; [
    vesktop
    kitty
    onlyoffice-desktopeditors
    vscode
    # microsoft-edge
    # google-chrome
    # mullvad-browser
    # heroic
    # protonplus
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

    packages = stablePkgs
      ++ unstablePkgs;
      # ++ [ grandLineAdventures ];
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

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      ls = "eza --icons";
      ll = "ls -la";
      la = "ls -a";
      bat = "bat --style=auto";
      ff = "fastfetch";
      nix-init-php = "nix flake init -t github:the-nix-way/dev-templates#php && echo 'use flake' > .envrc && direnv allow";
      nix-init-node = "nix flake init -t github:the-nix-way/dev-templates#node && echo 'use flake' > .envrc && direnv allow";
      da = "direnv allow";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
