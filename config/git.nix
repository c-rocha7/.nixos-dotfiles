{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Cauã R. Pereira";
        email = "7aauac@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
}
