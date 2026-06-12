{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    package = pkgs.unstable.fzf;

    defaultOptions = [
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];
  };
}
