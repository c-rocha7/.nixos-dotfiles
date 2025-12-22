{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ========================================
  # Boot e Kernel
  # ========================================

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernelParams = [
    "amd_pstate=disable"
    "kernel.split_lock_mitigate=0"
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  # ========================================
  # Hardware e Gráficos
  # ========================================

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

  # ========================================
  # Rede e Hostname
  # ========================================

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # ========================================
  # Locale e Teclado
  # ========================================

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

  # ========================================
  # Desktop e Display Manager
  # ========================================

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Outras opções comentadas (descomente se precisar):
  # services.desktopManager.gnome.enable = true;
  # services.desktopManager.cosmic.enable = true;
  # services.desktopManager.cosmic.xwayland.enable = true;
  # programs.hyprland = { enable = true; xwayland.enable = true; };

  # ========================================
  # Áudio
  # ========================================

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # ========================================
  # Serviços Gerais
  # ========================================

  services.printing.enable = true;

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

  security.rtkit.enable = true;
  security.polkit.enable = true;

  # ========================================
  # Usuários e Shell
  # ========================================

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  users.users.cauanixos = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "video" "audio" ];
  };

  # ========================================
  # Programas Específicos
  # ========================================

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
    # Essenciais
    stdenv.cc.cc.lib
    zlib
    fuse3
    icu
    dbus
    expat

    # Gráficos
    libGL
    fontconfig
    freetype
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi

    # Rede/Segurança
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

  # ========================================
  # Virtualização
  # ========================================

  virtualisation = {
    docker.enable = true;
    waydroid.enable = true;
    waydroid.package = pkgs.waydroid-nftables;
    libvirtd.enable = true;
  };

  # ========================================
  # Montagem de Discos NTFS
  # ========================================

  fileSystems."/home/cauanixos/Jogos/ssd-512-gb" = {
    device = "/dev/disk/by-uuid/F002C0CA02C096CE";
    fsType = "ntfs3";
    options = [ "defaults" "uid=1000" "gid=100" "nofail" "windows_names" ];
  };

  fileSystems."/home/cauanixos/Jogos/hd-1-tb" = {
    device = "/dev/disk/by-uuid/2ED6CE36D6CDFDD9";
    fsType = "ntfs3";
    options = [ "defaults" "uid=1000" "gid=100" "nofail" "windows_names" ];
  };

  # ========================================
  # Nixpkgs e Nix
  # ========================================

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

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
  # Fontes
  # ========================================

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.comic-shanns-mono
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.space-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.enable = true;

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
