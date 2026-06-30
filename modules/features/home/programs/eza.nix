{ ... }:

{
  flake.nixosModules.eza = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.eza = {
          enable = true;
        };
      };
    };
}
