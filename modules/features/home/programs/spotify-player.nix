{ ... }:

{
  flake.nixosModules.homeSpotifyPlayer = { ... }:
    {
      home-manager.users.cauanixos = {
        programs.spotify-player = {
          enable = true;
        };
      };
    };
}
