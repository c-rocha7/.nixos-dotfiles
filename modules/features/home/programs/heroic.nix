{ ... }:

{
  flake.nixosModules.heroic = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          unstable.heroic
        ];
      };
    };
}
