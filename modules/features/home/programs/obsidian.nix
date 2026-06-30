{ ... }:

{
  flake.nixosModules.obsidian = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.obsidian = {
          enable = true;
        };
      };
    };
}
