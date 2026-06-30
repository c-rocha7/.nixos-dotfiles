{ ... }:

{
  flake.nixosModules.bat = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.bat = {
          enable = true;
        };
      };
    };
}
