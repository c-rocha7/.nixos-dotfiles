{ config, pkgs, inputs, ... }:

{
    programs.firefox.enable = true;

    home.packages = 
    [
        pkgs.unstable.vscode
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
}
