{ ... }:

{
  flake.nixosModules.glaDesktopItem = { pkgs, ... }:
    {
      home-manager.users.cauanixos =
        let
          grandLineAdventures = pkgs.makeDesktopItem {
            name = "grand-line-adventures";
            desktopName = "Grand Line Adventures";
            comment = "Grand Line Adventures";
            terminal = false;
            exec = "/home/cauanixos/\"Grand Line Adventures\"/glaclient-linux";
            icon = "/home/cauanixos/Grand Line Adventures/assets/glaclient.png";
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
