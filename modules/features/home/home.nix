{ inputs, ... }:

{
  flake.nixosModules.home = { ... }:
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };

        users.cauanixos = { ... }: {
          home.username = "cauanixos";
          home.homeDirectory = "/home/cauanixos";
          home.stateVersion = "26.05";

          home.packages = [ ];

          programs.home-manager.enable = true;
        };
      };
    };
}
