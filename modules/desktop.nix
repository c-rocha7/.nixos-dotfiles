{ pkgs, ... }:

{
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd startplasma-wayland --remember --asterisks";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "alt-intl";
  };
  console.keyMap = "us-acentos";

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

  services.printing.enable = true;
  services.upower.enable = true;

  environment.systemPackages = [ pkgs.tuigreet ];
}
