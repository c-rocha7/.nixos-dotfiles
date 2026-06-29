{ ... }:

{
  flake.nixosModules.homeCava = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.cava = {
          enable = true;
        };
      };
    };
}
