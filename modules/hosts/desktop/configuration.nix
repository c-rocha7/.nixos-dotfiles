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

      hardware.cpu.amd.updateMicrocode = true;
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
