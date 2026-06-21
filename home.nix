{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home = {
    username = "cauanixos";
    homeDirectory = "/home/cauanixos";
    stateVersion = "26.05";

    packages = with pkgs; [
      tree
      fastfetch

      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

      unstable.btop
      unstable.bat
      unstable.eza
      unstable.cava
      unstable.vscode

      kitty
      rofi
      waybar
      mako
      hyprpaper
      wl-clipboard
    ];
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

    history = {
      save = 0;
      size = 1000;
      path = "/dev/null";
    };

    history.share = false;

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

  # wayland.windowManager.hyprland = {
  # 	enable = true;
  # 	systemd.enable = true;
  #   settings = {
  #     on = {
  #       _args = [
  #         "hyprland.start"
  #         (lua ''
  #           function()
  #             hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  #             hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  #           end
  #         '')
  #       ];
  #     };
  #   };
  # };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  programs.home-manager.enable = true;
}
