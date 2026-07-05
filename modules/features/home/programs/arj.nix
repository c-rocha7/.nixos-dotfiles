{ ... }:

{
  flake.nixosModules.arj = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          arj
        ];
      };
    };
}
