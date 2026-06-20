{ config, pkgs, ... }:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      bigclock = "en";
      bigclock_seconds = true;
      hide_key_hints = true;
      hide_version_string = true;
      lang = "pt";
      numlock = true;
    };
  };
}
