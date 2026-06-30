{ ... }:

{
  flake.nixosModules.spotifyPlayer = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.spotify-player = {
          enable = true;
        };
      };
    };
}
