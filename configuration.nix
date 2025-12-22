{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

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

  services.printing.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland --remember --asterisks";
        user = "greeter";
      };
    };
  };

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = with pkgs; [ linux-firmware ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa-demos
      vulkan-tools
    ];
  };

  hardware.amdgpu = {
    initrd.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      common = { default = [ "hyprland" "kde" ]; };
      hyprland = { default = [ "hyprland" "kde" ]; };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  users.users.cauanixos = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    micro
    git
    kitty
    fastfetch
    gst_all_1.gstreamer
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    flatpak
    xdg-desktop-portal-gtk
    zip
    unzip
    p7zip
    unrar
    arj
    networkmanagerapplet
    cava
    bat
    eza
    hyprlock
    hyprshot
    waybar
    kitty
    rofi
    pavucontrol
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.ark
    kdePackages.kio-admin
    kdePackages.kio-extras
    kdePackages.kio-fuse
    kdePackages.breeze-icons
    kdePackages.kdegraphics-thumbnailers
    libsForQt5.kinit
    kdePackages.kservice
    kdePackages.polkit-kde-agent-1
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    gnome-keyring
    kdePackages.breeze
    kdePackages.breeze-gtk
    papirus-icon-theme
    nwg-look
    kdePackages.kde-cli-tools
    cpio
    swaynotificationcenter
    wlogout
    vscode
    libsForQt5.qt5ct
    kdePackages.qt6ct
    waypaper
    swww
    cliphist
    wl-clipboard
    adwaita-icon-theme
  ];

  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
    pkgs.font-awesome
	nerd-fonts.comic-shanns-mono
	nerd-fonts.fantasque-sans-mono
	nerd-fonts.fira-code
	nerd-fonts.jetbrains-mono
    nerd-fonts.space-mono    
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];
  fonts.fontconfig.enable = true;

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  stylix.enable = true;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

  stylix.fonts = {
    monospace = {
      package = pkgs.jetbrains-mono;
      name = "JetBrains Mono";
    };
    sansSerif = {
      package = pkgs.inter;
      name = "Inter";
    };
    serif = {
      package = pkgs.iosevka;
      name = "Iosevka";
    };
    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };
  };
  
  stylix.polarity = "dark";

  # stylix.targets.console.enable = true;
  # stylix.targets.grub.enable = true;  # Tema no GRUB
  # stylix.targets.plymouth.enable = true;  # Tema no boot
  # stylix.targets.gnome.enable = true;
  # stylix.targets.gtk.enable = true;
  # stylix.targets.qt.enable = true;
  # stylix.targets.plasma.enable = true;

  system.stateVersion = "25.11";
}
