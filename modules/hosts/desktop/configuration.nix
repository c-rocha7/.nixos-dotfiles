{ self, ... }:

{
  flake.nixosModules.desktopConfiguration = { pkgs, lib, ... }:
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

      networking.hostName = "nixos";

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

      services.power-profiles-daemon.enable = false;
      services.auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            gorvernor = "performance";
            turbo = "auto";
          };
        };
      };

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

      users.users."cauanixos" = {
        isNormalUser = true;
        description = "Cauã R. Pereira";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
        packages = [ ];
      };

      environment.sessionVariables = {
        MESA_SHADER_CACHE_MAX_SIZE = "12G";
      };

      system.stateVersion = "26.05";
    };
}
