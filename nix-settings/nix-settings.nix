{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
