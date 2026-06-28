{ self, inputs, ... }:

{
  flake.nixosModules.homeBrowser = { config, lib, pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        programs.firefox.enable = true;

        home.packages = with pkgs; [
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      };
    };
}
