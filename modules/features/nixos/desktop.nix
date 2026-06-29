{ ... }:

{
  flake.nixosModules.nixosDesktop = { pkgs, ... }:
    {
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
    };
}
