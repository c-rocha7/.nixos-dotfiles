{ inputs, ... }:

{
  flake.nixosModules.homeShared = { ... }:
    let
      username = "cauanixos";
    in
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };

        users.${username} = { pkgs, ... }: {
          home.username = username;
          home.homeDirectory = "/home/${username}";
          home.stateVersion = "26.05";

          home.packages = with pkgs; [
            onlyoffice-desktopeditors
            nil
            nixd
            nixpkgs-fmt
          ];

          programs.home-manager.enable = true;
        };
      };
    };
}
