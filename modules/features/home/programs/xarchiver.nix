{ ... }:

{
  flake.nixosModules.xarchiver = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          xarchiver
        ];
      };
    };
}
