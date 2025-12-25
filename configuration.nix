{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/audio.nix
      ./modules/desktop.nix
      ./modules/gaming.nix
      ./modules/hardware.nix
      ./modules/i18n.nix
      ./modules/storage.nix
      ./modules/users.nix
      ./modules/virtualization.nix
    ];

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

  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

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

  programs.firefox.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    micro
    php
    php.packages.composer
    nodejs_24
    python314
    ntfs3g
    p7zip
    file

    unstable.fastfetch
    unstable.lazygit
    unstable.lazydocker
    unstable.docker-compose

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  environment.sessionVariables = {
    MESA_SHADER_CACHE_MAX_SIZE = "12G";
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
