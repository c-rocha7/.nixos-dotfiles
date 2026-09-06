{ ... }:

{
  flake.nixosModules.claude-code = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.claude-code = {
          enable = true;
        };
      };
    };
}
