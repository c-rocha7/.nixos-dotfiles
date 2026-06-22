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

      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

      wl-clipboard
      waypaper
      pavucontrol
      nwg-look
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.breeze
      kdePackages.breeze-gtk
      papirus-icon-theme
      libsForQt5.qtstyleplugin-kvantum
      qt6Packages.qtstyleplugin-kvantum
      kdePackages.qtstyleplugin-kvantum
      catppuccin-kvantum
      magnetic-catppuccin-gtk
    ];
  };

  services.swaync.enable = true;
  services.hyprpaper.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  programs.hyprshot.enable = true;
  programs.wlogout.enable = true;
  services.awww.enable = true;

  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
  };

  programs.fastfetch.enable = true;
  programs.yazi.enable = true;
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.eza.enable = true;
  programs.cava.enable = true;
  programs.kitty.enable = true;
  programs.rofi.enable = true;
  programs.waybar.enable = true;

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

  wayland.windowManager.hyprland = {
  	enable = true;
    package = pkgs.unstable.hyprland;
    xwayland.enable = true;
    systemd.enable = false;
    importantPrefixes = [ ];
  };

  home.file.hyprland = {
    recursive = false;
    source = ./hypr/hyprland.lua;
    target = "./.config/hypr/hyprland.lua";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  programs.home-manager.enable = true;
}
