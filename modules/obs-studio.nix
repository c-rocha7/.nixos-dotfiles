{ config, pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;

    package = pkgs.unstable.obs-studio;

    plugins = with pkgs.unstable.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };
}
