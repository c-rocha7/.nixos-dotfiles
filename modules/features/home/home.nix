{ inputs, ... }:

{
  flake.nixosModules.home = { ... }:
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };

        users.cauanixos = { pkgs, ... }: {
          home.username = "cauanixos";
          home.homeDirectory = "/home/cauanixos";
          home.stateVersion = "26.05";

          home.packages = with pkgs; [
            onlyoffice-desktopeditors
            nil
            nixd
            nixpkgs-fmt
          ];

          programs.home-manager.enable = true;
        };
      };
    };
}
