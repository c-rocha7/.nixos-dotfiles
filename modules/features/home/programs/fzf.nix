{ ... }:

{
  flake.nixosModules.fzf = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.fzf = {
          enable = true;
          enableZshIntegration = true;
          enableBashIntegration = true;
          defaultOptions = [
            "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
          ];
        };
      };
    };
}
