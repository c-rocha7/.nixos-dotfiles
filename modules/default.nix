{ config, pkgs, ... }:

{
  imports = [
    ./dev-tools.nix
    ./fzf.nix
    ./git.nix
    ./mise.nix
    ./obs-studio.nix
    ./terminal.nix
    ./zsh.nix
  ];
}
