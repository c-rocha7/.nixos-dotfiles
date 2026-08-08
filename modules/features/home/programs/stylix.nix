{ inputs, ... }:

{
  flake.nixosModules.stylix = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        imports = [
          inputs.stylix.homeModules.stylix
        ];

        stylix = {
          enable = true;

          base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

          cursor = {
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
            size = 24;
          };

          fonts = {
            serif = { name = "LiterationSerif Nerd Font"; };
            sansSerif = { name = "LiterationSans Nerd Font"; };
            monospace = { name = "LiterationMono Nerd Font"; };
            emoji = { name = "Noto Color Emoji"; };
          };

          icons = {
            enable = true;
            package = pkgs.papirus-icon-theme;
            dark = "Papirus-Dark";
            light = "Papirus-Light";
          };

          polarity = "dark";
        };
      };
    };
}
