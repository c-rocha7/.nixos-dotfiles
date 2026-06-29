{ ... }:

{
  flake.nixosModules.homeBtop = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.btop = {
          enable = true;
        };
      };
    };
}
