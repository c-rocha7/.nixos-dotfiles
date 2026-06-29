{ ... }:

{
  flake.nixosModules.homeFastfetch = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.fastfetch = {
          enable = true;
        };
      };
    };
}
