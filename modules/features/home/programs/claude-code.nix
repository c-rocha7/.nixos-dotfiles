{ ... }:

{
  flake.nixosModules.claude-code = { ... }:
    {
      home-manager.users."7aauac" = {
        programs.claude-code = {
          enable = true;
        };
      };
    };
}
