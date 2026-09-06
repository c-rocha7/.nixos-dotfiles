{ ... }:

{
  flake.nixosModules.dev = { pkgs, ... }:
    {
      home-manager.users."7aauac" = {
        home.packages = with pkgs; [
          devenv
          navicat-premium
        ];

        programs.vscode = {
          enable = true;
          package = pkgs.unstable.vscode;
        };

        programs.direnv = {
          enable = true;
          enableZshIntegration = true;

          nix-direnv = {
            enable = true;
          };
        };
      };
    };
}
