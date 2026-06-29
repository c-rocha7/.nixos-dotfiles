{ ... }:

{
  flake.nixosModules.homeCode = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          devenv
        ];

        programs.vscode = {
          enable = true;
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
