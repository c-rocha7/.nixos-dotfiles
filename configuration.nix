{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/gaming.nix
    ./modules/virtualization.nix
    ./modules/desktop.nix
    ./modules/hardware.nix
    ./modules/storage.nix
    ./modules/i18n.nix
    ./modules/audio.nix
    ./modules/users.nix
  ];

  # ========================================
  # Boot e Kernel
  # ========================================

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # ========================================
  # Rede e Hostname
  # ========================================

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  # ========================================
  # Desktop e Display Manager
  # ========================================

  services.xserver.enable = true;

  # Outras opções comentadas (descomente se precisar):
  # services.desktopManager.gnome.enable = true;
  # services.desktopManager.cosmic.enable = true;
  # services.desktopManager.cosmic.xwayland.enable = true;
  # programs.hyprland = { enable = true; xwayland.enable = true; };

  # ========================================
  # Serviços Gerais
  # ========================================

  # Flatpak com repositório Flathub
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    remotes = lib.mkOptionDefault [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "com.github.tchx84.Flatseal"
      "com.pokemmo.PokeMMO"
      "io.github.kolunmi.Bazaar"
    ];
  };

  # ========================================
  # Programas Específicos
  # ========================================

  programs.firefox.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };

  # ========================================
  # Nixpkgs e Nix
  # ========================================

  nixpkgs.config.allowUnfree = true;

  # ========================================
  # Ambiente e Pacotes
  # ========================================

  environment.systemPackages = with pkgs; [
    vim
    wget
    micro
    git
    unstable.docker-compose
    php
    php.packages.composer
    nodejs_24
    python314
    unstable.lazygit
    unstable.lazydocker
    ntfs3g
    unstable.fastfetch
    p7zip
    file
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    unstable.steam-run
  ];

  environment.sessionVariables = {
    MESA_SHADER_CACHE_MAX_SIZE = "12G";
  };

  # ========================================
  # Scripts de Ativação Customizados
  # ========================================
  system.activationScripts.installNavicat = {
    text = ''
      # Instala diretamente do arquivo ref sem precisar adicionar remote manualmente
      ${pkgs.flatpak}/bin/flatpak install -y --from https://dn.navicat.com/flatpak/flatpakref/navicat17/com.navicat.premium.en.flatpakref || true
    '';
  };

  # ========================================
  # Versão do Sistema
  # ========================================

  system.stateVersion = "25.11";
}
