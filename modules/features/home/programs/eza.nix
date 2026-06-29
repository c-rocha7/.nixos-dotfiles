{ ... }:

{
  flake.nixosModules.homeEza = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.eza = {
          enable = true;
        };
      };
    };
}
