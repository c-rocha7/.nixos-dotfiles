{ self, inputs, ... }:

{
  flake.nixosModules.sharedHome = { config, lib, pkgs, ... }:
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
            tree
            inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
            onlyoffice-desktopeditors
            vscode
            nil
            nixd
            nixpkgs-fmt
          ];

          programs.home-manager.enable = true;

          programs.git = {
            enable = true;

            settings = {
              user = {
                name = "Cauã R. Pereira";
                email = "7aauac@gmail.com";
              };

              extraConfig = {
                init.defaultBranch = "main";
              };
            };
          };
        };
      };
    };
}
