{ pkgs, ... }:

{
  users.users.cauanixos = {
    isNormalUser = true;
    description = "cauanixos";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  security.polkit.enable = true;
}
