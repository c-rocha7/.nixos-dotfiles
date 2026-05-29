{ config, pkgs, inputs, ... }:

{
  home.username = "cauanixos";
  home.homeDirectory = "/home/cauanixos";
  home.stateVersion = "25.11";

  imports = [
    ./modules
    ./programs/fastfetch
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  programs.home-manager.enable = true;
}
