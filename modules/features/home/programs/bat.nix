{ ... }:

{
  flake.nixosModules.bat = { ... }:
    {
      home-manager.users."7aauac" = {
        programs.bat = {
          enable = true;
        };
      };
    };
}
