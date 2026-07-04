{ ... }:

{
  flake.nixosModules.p7zip = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home-packages = with pkgs; [
          p7zip
        ];
      };
    };
}
