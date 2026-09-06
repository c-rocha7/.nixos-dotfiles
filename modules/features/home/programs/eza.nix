{ ... }:

{
  flake.nixosModules.eza = { ... }:
    {
      home-manager.users."7aauac" = {
        programs.eza = {
          enable = true;
        };
      };
    };
}
