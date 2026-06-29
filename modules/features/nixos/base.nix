{ ... }:

{
  flake.nixosModules.nixosBase = { ... }:
    {
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

      services.printing.enable = true;
      services.earlyoom.enable = true;
      services.resolved.enable = true;
      services.upower.enable = true;

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

      programs.zsh.enable = true;

      documentation = {
        dev.enable = true;
        doc.enable = true;
        man.enable = true;
        info.enable = true;
        nixos.enable = true;
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

      environment.systemPackages = [ ];
    };
}
