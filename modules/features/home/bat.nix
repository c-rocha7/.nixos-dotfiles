{ ... }:

{
  flake.nixosModules.homeBat = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.bat = {
          enable = true;
        };
      };
    };
}
