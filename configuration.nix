# =============================================================================
# 1. IMPORTAÇÕES E PARÂMETROS DE HARDWARE (AMD RYZEN & RADEON)
# =============================================================================

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/audio.nix
    ./modules/desktop.nix
    # ./modules/gaming.nix
    ./modules/hardware.nix
    ./modules/i18n.nix
    ./modules/storage.nix
    ./modules/users.nix
    ./modules/virtualization.nix
  ];

  # Kernel otimizado para Desktop/Gaming
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # =============================================================================
  # 2. SISTEMA DE BOOT (GRUB)
  # =============================================================================

  boot.loader = {
    systemd-boot.enable = false;

    efi = {
      canTouchEfiVariables = true;
    };

    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = false;
      useOSProber = false;
      configurationLimit = 10;
    };
  };

  # =============================================================================
  # 3. REDE
  # =============================================================================

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  services.resolved.enable = true;

  # =============================================================================
  # 4. PROGRAMAS E FLATPAK
  # =============================================================================

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    micro
    btop
    podman-compose
    unstable.eza
    unstable.bat
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

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
      "io.github.kolunmi.Bazaar"
      "org.kde.kalk"
      "io.github.flattool.Warehouse"
    ];
  };

  # =============================================================================
  # 5. VARIÁVEIS DE SISTEMA
  # =============================================================================

  environment.sessionVariables = {
    MESA_SHADER_CACHE_MAX_SIZE = "12G";
  };

  # =============================================================================
  # 7. CONFIGURAÇÕES DO NIX
  # =============================================================================

  nixpkgs.config.allowUnfree = true;

  # Versão de estado inicial do sistema
  system.stateVersion = "25.11";
}
