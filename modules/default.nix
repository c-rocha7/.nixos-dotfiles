{ config, pkgs, ... }:

{
  imports = [
    ./terminal.nix
    ./dev-tools.nix
    ./git.nix
  ];
}
