{ ... }:

{
  flake.nixosModules.glaDesktopItem = { pkgs, ... }:
    {
      home-manager.users."7aauac" =
        let
          grandLineAdventures = pkgs.makeDesktopItem {
            name = "grand-line-adventures";
            desktopName = "Grand Line Adventures";
            comment = "Grand Line Adventures";
            terminal = false;
            exec = "/home/7aauac/\"Grand Line Adventures\"/glaclient-linux";
            icon = "/home/7aauac/Grand Line Adventures/assets/glaclient.png";
            type = "Application";
            categories = [ "Game" ];
            keywords = [ "game" ];
            startupNotify = true;
            startupWMClass = "glaclient-linux";
          };
        in
        {
          home.packages = [
            grandLineAdventures
          ];
        };
    };
}
