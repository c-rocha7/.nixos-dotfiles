{ ... }:

{
  flake.nixosModules.obsidian = { ... }:
    {
      home-manager.users."7aauac" = {
        programs.obsidian = {
          enable = true;
        };
      };
    };
}
