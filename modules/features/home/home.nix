{ inputs, ... }:

{
  flake.nixosModules.home = { pkgs, ... }:
    {
      home-manager = {
        useGlobalPkgs = false;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        backupFileExtension = "backup";

        users.cauanixos = { ... }: {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable {
                system = prev.stdenv.hostPlatform.system;
                config.allowUnfree = true;
              };
            })
          ];

          home.username = "cauanixos";
          home.homeDirectory = "/home/cauanixos";
          home.stateVersion = "26.05";

          home.packages = with pkgs; [
            papirus-icon-theme
            bibata-cursors
          ];

          programs.home-manager.enable = true;
        };
      };
    };
}
