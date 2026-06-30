{ inputs, ... }:

{
  flake.nixosModules.browsers = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        programs.firefox.enable = true;

        home.packages = [
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      };
    };
}
