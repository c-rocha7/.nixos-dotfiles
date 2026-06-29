{ ... }:

{
  flake.nixosModules.nixosUserCauanixos = { pkgs, ... }:
    {
      users.users."cauanixos" = {
        isNormalUser = true;
        description = "Cauã R. Pereira";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
        packages = [ ];
      };
    };
}
