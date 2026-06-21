{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];
 
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernelParams = [
    "amd_pstate=disable"
    "kernel.split_lock_mitigate=0"
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  services.xserver.videoDrivers = [ "amdgpu" ];
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  hardware.enableRedistributableFirmware = true;

  boot.loader = {
    systemd-boot.enable = false;
    grub.enable = false;
    efi.canTouchEfiVariables = true;

    limine = {
      enable = true;
      maxGenerations = 10;
    };
  };

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

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

  services.resolved.enable = true;

  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  console.keyMap = "br-abnt2";

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      bigclock = "en";
      bigclock_seconds = true;
      hide_key_hints = true;
      hide_version_string = true;
      lang = "pt";
      numlock = true;
    };
  };

  services.desktopManager.plasma6.enable = true;

  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  security.polkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  services.upower.enable = true;

  services.printing.enable = true;

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

    packages = [ ];
  };

  users.users.cauanixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;

  programs.gamemode.enable = true;

  programs.zsh.enable = true;

  fonts.fontconfig.enable = true;

  virtualisation.libvirtd.enable = true;

  programs.virt-manager.enable = true;

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.comic-shanns-mono
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.space-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  zramSwap = {
    enable = true;
    memoryMax = 8192 * 1024 * 1024;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    micro
    btop
  ];

  environment.sessionVariables = {
    MESA_SHADER_CACHE_MAX_SIZE = "12G";
  };

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "26.05";
}
