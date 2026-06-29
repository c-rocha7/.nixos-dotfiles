{ ... }:

{
  flake.nixosModules.homeObsidian = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.obsidian = {
          enable = true;
        };
      };
    };
}
