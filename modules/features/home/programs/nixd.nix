{ ... }:

{
  flake.nixosModules.nixd = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          nixd
        ];
      };
    };
}
