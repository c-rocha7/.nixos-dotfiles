{ config, pkgs, inputs, ... }:

{
  home = {
    username = "cauanixos";
    homeDirectory = "/home/cauanixos";
    stateVersion = "26.05";

    packages = with pkgs; [
      tree
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    package = pkgs.unstable.fzf;

    defaultOptions = [
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Cauã R. Pereira";
        email = "7aauac@gmail.com";
      };

      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };

  programs.obs-studio = {
    enable = true;

    package = pkgs.unstable.obs-studio;

    plugins = with pkgs.unstable.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
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
      ".." = "cd ..";
      "..." = "cd ../..";
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --group-directories-first";
      la = "ls -a";
      bat = "bat --style=auto";
      ff = "fastfetch";
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  programs.home-manager.enable = true;
}
