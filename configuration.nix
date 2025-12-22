{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernelParams = [
    "amd_pstate=disable"
    "kernel.split_lock_mitigate=0"
  ];
  boot.supportedFilesystems = [ "ntfs" ];

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

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

  hardware = {
    enableAllFirmware = true;
    firmware = [ pkgs.linux-firmware ];

    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
        rocmPackages.clr.icd
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
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

  # services.displayManager.ly.enable = true;

  # KDE Plasma
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        libva
        udev
        pciutils
        xorg.libXScrnSaver
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-ugly
        gst_all_1.gst-libav
      ];
    };
  };

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
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };

  virtualisation = {
    docker.enable = true;
    waydroid.enable = true;
    waydroid.package = pkgs.waydroid-nftables;
  };

  nixpkgs.config.allowUnfree = true;

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
