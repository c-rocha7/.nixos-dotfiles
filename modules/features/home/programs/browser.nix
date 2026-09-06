{ inputs, ... }:

{
  flake.nixosModules.browsers = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        programs.firefox.enable = true;

        home.packages = with pkgs; [
          google-chrome
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
          microsoft-edge
        ];
      };
    };
}
