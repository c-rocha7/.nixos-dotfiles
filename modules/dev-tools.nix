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
  ];
}
