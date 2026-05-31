{ config, pkgs, ... }:

{
    fonts.fontconfig.enable = true;

    fonts.fonts = with pkgs; 
    [
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
}
