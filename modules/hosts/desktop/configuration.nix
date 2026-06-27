{ self, inputs, ... }:

{
  flake.nixosModules.desktopConfiguration = { pkgs, ... }: {
    imports = [
      self.nixosModules.desktopHardware
      self.nixosModules.niri
    ];

    boot.loader.systemd-boot.enable = false;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.limine.enable = true;

    hardware.cpu.amd.updateMicrocode = true;

    boot.kernelParams = [ "amd_pstate=disable" ];
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

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

    services.xserver.enable = true;

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

    services.xserver.xkb = {
      layout = "br";
      variant = "";
    };

    console.keyMap = "br-abnt2";

    services.printing.enable = true;

    security.polkit.enable = true;
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users."cauanixos" = {
      isNormalUser = true;
      description = "Cauã R. Pereira";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [
        tree
        vscode
        nixd
        nixfmt
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        pavucontrol
        papirus-icon-theme
        fastfetch
        yazi
        bat
        btop
        eza
        cava
        fzf
        kitty
        libsForQt5.qt5ct
        catppuccin-qt5ct
        kdePackages.qt6ct
        catppuccin-qt5ct
        libsForQt5.qtstyleplugin-kvantum
        kdePackages.qtstyleplugin-kvantum
        catppuccin-kvantum
        catppuccin-gtk
        nwg-look
        qview
      ];
    };

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

    zramSwap = {
      enable = true;
      memoryMax = 8192 * 1024 * 1024;
    };

    environment.sessionVariables = {
      MESA_SHADER_CACHE_MAX_SIZE = "12G";

      TERMINAL = "kitty";

      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "niri";

      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";

      GDK_BACKEND = "wayland,x11,*";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";

      MOZ_ENABLE_WAYLAND = "1";
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs.firefox.enable = true;
    programs.git.enable = true;
    programs.vim.enable = true;
    programs.corectrl.enable = true;
    programs.thunar.enable = true;
    services.tumbler.enable = true;

    services.gnome.gnome-keyring.enable = true;

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome ];

    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      polarity = "dark";
      fonts = {
        serif = {
          name = "LiberationSerif Nerd Font Regular";
        };
        sansSerif = {
          name = "LiberationSans Nerd Font Regular";
        };
        monospace = {
          name = "LiberationMono Nerd Font Regular";
        };
        emoji = {
          name = "Noto Color Emoji";
        };
      };
      cursor = {
        name = "Catppuccin-Mocha";
        package = pkgs.catppuccin-cursors;
        size = 24;
      };
    };

    environment.systemPackages = with pkgs; [
      wget
    ];

    system.stateVersion = "26.05";
  };
}
