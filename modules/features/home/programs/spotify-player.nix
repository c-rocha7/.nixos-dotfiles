{ ... }:

{
  flake.nixosModules.spotifyPlayer = { ... }:
    {
      home-manager.users."7aauac" = {
        programs.spotify-player = {
          enable = true;
        };
      };
    };
}
