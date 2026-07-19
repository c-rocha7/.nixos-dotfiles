{ inputs, ... }:

{
  flake.nixosModules.browsers = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = [
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      };
    };
}
