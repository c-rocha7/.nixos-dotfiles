{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernelParams = [ "amd_pstate=disable" ];
  boot.supportedFilesystems = [ "ntfs" ];

  # SSD 512 GB
  fileSystems."/home/cauanixos/Jogos/ssd-512-gb" = {
    device = "/dev/disk/by-uuid/F002C0CA02C096CE";
    fsType = "ntfs3";
    options = [
      "defaults"
      "uid=1000"
      "gid=100"
      "nofail"
      "windows_names"
    ];
  };

  # HD 1 TB
  fileSystems."/home/cauanixos/Jogos/hd-1-tb" = {
    device = "/dev/disk/by-uuid/2ED6CE36D6CDFDD9";
    fsType = "ntfs3";
    options = [
      "defaults"
      "uid=1000"
      "gid=100"
      "nofail"
      "windows_names"
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "pt_BR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  console.keyMap = "us-acentos";

  services.xserver.xkb = {
    layout = "us";
    variant = "alt-intl";
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  services.printing.enable = true;

  services.displayManager.ly.enable = true;

  # KDE Plasma
  services.desktopManager.plasma6.enable = true;

  # Gnome
  # services.desktopManager.gnome.enable = true;

  # Cosmic
  # services.desktopManager.cosmic.enable = true;
  # services.desktopManager.cosmic.xwayland.enable = true;

  # Hyprland
  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  users.users.cauanixos = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  programs.firefox.enable = true;

  programs.steam.enable = true;

  programs.gamemode.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Essenciais e Sistema
    stdenv.cc.cc.lib
    zlib
    fuse3
    icu
    dbus
    expat

    # Gráficos e Interface
    libGL
    fontconfig
    freetype
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi

    # Rede e Segurança
    openssl
    curl
    nss
    nspr

    # Áudio
    libpulseaudio
    alsa-lib
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
    ];
  };

  virtualisation = {
    docker.enable = true;
    waydroid.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    micro
    git
    docker-compose
    php
    php.packages.composer
    nodejs_24
    python314
    lazygit
    lazydocker
    ntfs3g
    fastfetch
    p7zip
    file
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    pkgs.font-awesome
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.space-mono
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.comic-shanns-mono
    nerd-fonts.fira-code
  ];
  fonts.fontconfig.enable = true;

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
