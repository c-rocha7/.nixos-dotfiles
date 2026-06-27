{ self, inputs, ... }:

{
  flake.nixosModules.desktopConfiguration = 
    {
      config,
      pkgs,
      lib,
      ...
    }:

    {
      imports = [
        self.nixosModules.desktopHardware
      ];

      boot.initrd.kernelModules = [ "amdgpu" ];
      # boot.kernelPackages = pkgs.linuxPackages_zen;
      boot.kernelParams = [
        "amd_pstate=disable"
        "kernel.split_lock_mitigate=0"
      ];
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.limine.enable = true;
      boot.loader.systemd-boot.enable = false;
      boot.supportedFilesystems = [ "ntfs" ];

      console.keyMap = "br-abnt2";

      documentation.dev.enable = true;
      documentation.doc.enable = true;
      documentation.man.enable = true;
      documentation.info.enable = true;
      documentation.nixos.enable = true;

      environment.sessionVariables = {
        MESA_SHADER_CACHE_MAX_SIZE = "12G";
      };
      environment.systemPackages = with pkgs; [ ];
      environment.variables.RUSTICL_ENABLE = "radeonsi";

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

      hardware.amdgpu.opencl.enable = true;
      hardware.cpu.amd.updateMicrocode = true;
      hardware.graphics = {
        enable = true;
        enable32Bit = true;

        extraPackages = with pkgs; [
          rocmPackages.clr.icd
        ];
      };

      # home-manager = {
      #   extraSpecialArgs = { inherit inputs; };
      #   users = {
      #     cauanixos = ;
      #   };
      # };

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

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ ];
        allowedUDPPorts = [ ];
      };
      networking.hostName = "nixos";
      networking.networkmanager.enable = true;
      nix.gc.automatic = true;
      nix.gc.dates = "weekly";
      nix.gc.options = "--delete-older-than 7d";
      nix.settings.auto-optimise-store = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      nixpkgs.config.allowUnfree = true;

      programs.firefox.enable = true;
      programs.nix-ld.enable = true;

      # services.auto-cpufreq = {
      #   enable = true;
      #   settings = {
      #     battery = {
      #       governor = "powersave";
      #       turbo = "never";
      #     };
      #     charger = {
      #       gorvernor = "performance";
      #       turbo = "auto";
      #     };
      #   };
      # };
      services.desktopManager.gnome.enable = true;
      # services.desktopManager.plasma6.enable = true;
      services.displayManager.gdm.enable = true;
      # services.displayManager.ly.enable = true;
      # services.displayManager.sddm.enable = true;
      # services.displayManager.sddm.wayland.enable = true;
      services.earlyoom.enable = true;
      services.flatpak = {
        enable = true;

        packages = [ ];

        remotes = lib.mkOptionDefault [
          {
            name = "flathub";
            location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
          }
        ];

        update.auto.enable = true;
        update.auto.onCalendar = "weekly";
      };
      services.resolved.enable = true;
      security.rtkit.enable = true;
      services.pipewire = {
        alsa.enable = true;
        alsa.support32Bit = true;
        enable = true;
        jack.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };
      services.printing.enable = true;
      services.pulseaudio.enable = false;
      services.upower.enable = true;
      services.xserver.enable = true;
      services.xserver.videoDrivers = [ "amdgpu" ];
      services.xserver.xkb = {
        layout = "br";
        variant = "";
      };
      system.stateVersion = "26.05";

      time.timeZone = "America/Sao_Paulo";

      users.users."cauanixos" = {
        description = "Cauã R. Pereira";
        extraGroups = [ "networkmanager" "wheel" ];
        isNormalUser = true;
        packages = with pkgs; [
          davinci-resolve
          fastfetch
          git
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
          onlyoffice-desktopeditors
          pavucontrol
          tree
          vesktop
          vscode
        ];
      };

      zramSwap = {
        algorithm = "zstd";
        enable = true;
        memoryMax = 8192 * 1024 * 1024;
        priority = 100;
      };
    };
}