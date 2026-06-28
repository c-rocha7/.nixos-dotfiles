{ self, inputs, ... }:

{
  flake.nixosModules.desktopConfiguration = { config, pkgs, lib, ... }:
  {
    imports = [
      self.nixosModules.desktopHardware
    ];

    boot.loader.systemd-boot.enable = false;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.limine.enable = true;

    boot.kernelParams = [
      "amd_pstate=disable"
      "kernel.split_lock_mitigate=0"
    ];

    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.supportedFilesystems = [ "ntfs" ];

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

    hardware.cpu.amd.updateMicrocode = true;
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" ];

    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
      font-awesome
      nerd-fonts.comic-shanns-mono
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.liberation
      nerd-fonts.jetbrains-mono
      nerd-fonts.space-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
    ];

    services.xserver.xkb = {
      layout = "br";
      variant = "";
    };

    console.keyMap = "br-abnt2";

    services.printing.enable = true;
    services.earlyoom.enable = true;
    services.resolved.enable = true;
    services.upower.enable = true;

    services.flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"
        "io.github.flattool.Warehouse"
        "io.github.kolunmi.Bazaar"
        "org.kde.kalk"
      ];
      remotes = lib.mkOptionDefault [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];
      update.auto.enable = true;
      update.auto.onCalendar = "weekly";
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    users.users."cauanixos" = {
      isNormalUser = true;
      description = "Cauã R. Pereira";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        tree
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        onlyoffice-desktopeditors
        vscode
      ];
    };

    documentation = {
      dev.enable = true;
      doc.enable = true;
      man.enable = true;
      info.enable = true;
      nixos.enable = true;
    };

    zramSwap = {
      algorithm = "zstd";
      enable = true;
      memoryMax = 8192 * 1024 * 1024;
      priority = 100;
    };

    programs.firefox.enable = true;
    programs.git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        user.name = "Cauã R. Pereira";
        user.email = "7aauac@gmail.com";
      };
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

    environment.systemPackages = with pkgs; [ ];

    environment.sessionVariables = {
      MESA_SHADER_CACHE_MAX_SIZE = "12G";
    };

    system.stateVersion = "26.05";
  };
}
