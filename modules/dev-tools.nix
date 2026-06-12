{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.firefox.enable = true;

  home.packages = [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.unstable.vscode
    pkgs.unstable.kdePackages.kdenlive
    pkgs.mpv
    pkgs.unstable.obsidian
    pkgs.unstable.kitty
    pkgs.unstable.nixfmt
  ];
}
