{ self, ... }:

{
  flake.nixosModules.laptopConfiguration = { pkgs, lib, ... }:
    {
      imports =
        [
          self.nixosModules.laptopHardware
          self.nixosModules.git
          self.nixosModules.vim
        ];

      boot.loader.systemd-boot.enable = false;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.limine.enable = true;

      boot.kernelPackages = pkgs.linuxPackages_zen;

      networking.hostName = "nixos-laptop";

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

      services.displayManager.sddm.enable = true;
      services.desktopManager.plasma6.enable = true;

      fonts.fontconfig.enable = true;
      fonts.packages = with pkgs; [
        font-awesome
        nerd-fonts.code-new-roman
        nerd-fonts.comic-shanns-mono
        nerd-fonts.dejavu-sans-mono
        nerd-fonts.fantasque-sans-mono
        nerd-fonts.fira-code
        nerd-fonts.fira-mono
        nerd-fonts.jetbrains-mono
        nerd-fonts.liberation
        nerd-fonts.noto
        nerd-fonts.roboto-mono
        nerd-fonts.space-mono
        nerd-fonts.symbols-only
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

      services.flatpak = {
        enable = true;
        packages = [
          "com.ranfdev.DistroShelf"
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
      security.sudo.extraConfig = ''
        Defaults pwfeedback
      '';
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
      };

      services.udev.extraRules = ''
        KERNEL=="ttyACM*", ATTRS{idVendor}=="0324", ATTRS{idProduct}=="0324", SYMLINK+="minitela_display", MODE="0666"
      '';

      users.users."cauanixos" = {
        isNormalUser = true;
        description = "Cauã Rocha Pereira";
        extraGroups = [ "networkmanager" "wheel" "podman" ];
        packages = [ ];
      };

      documentation = {
        dev.enable = true;
        doc.enable = true;
        man.enable = true;
        info.enable = true;
        nixos.enable = true;
      };

      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
      };

      nixpkgs.config.allowUnfree = true;

      nix.settings = {
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [ "root" "@wheel" ];
      };

      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      environment.systemPackages = [ ];

      environment.sessionVariables = {
        MESA_SHADER_CACHE_MAX_SIZE = "12G";
        # GTK_IM_MODULE = "simple";
      };

      system.stateVersion = "26.05";
    };
}
