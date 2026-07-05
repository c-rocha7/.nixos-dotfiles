{ ... }:

{
  flake.nixosModules.nixpkgsFmt = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          nixpkgs-fmt
        ];
      };
    };
}
