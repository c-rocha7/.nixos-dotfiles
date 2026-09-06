{ ... }:

{
  flake.nixosModules.fzf = { ... }:
    {
      home-manager.users."7aauac" = {
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
