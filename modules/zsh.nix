{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
    };

    shellAliases = {
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --group-directories-first";
      cat = "bat";
      g = "git";
      nix-switch = "sudo nixos-rebuild switch --flake .#nixos";
      nix-boot = "sudo nixos-rebuild boot --flake .#nixos";
    };

    initContent = ''
      fastfetch
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      character = {
        success_symbol = "[➜](bold green) ";
        error_symbol = "[➜](bold red) ";
      };

      git_branch = {
        symbol = "🌿 ";
        style = "bold purple";
      };
    };
  };
}
