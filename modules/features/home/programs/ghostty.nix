{ ... }:

{
  flake.nixosModules.ghostty = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        programs.ghostty = {
          enable = true;
          enableZshIntegration = true;

          settings = {
            command = "${pkgs.zsh}/bin/zsh";

            # Aparência
            theme = "catppuccin-mocha";
            font-size = 12.0;
            font-family = "FiraCode Nerd Font";
            background-opacity = 0.95;
            window-padding-x = 8;
            window-padding-y = 8;
            cursor-style = "block";
            cursor-style-blink = false;
            window-width = 120;
            window-height = 40;

            # Comportamento
            copy-on-select = true;
            scrollback-limit = 10000;

            # Atalhos
            keybind = [
              # Divisões
              "ctrl+shift+e=new_split:right"
              "ctrl+shift+o=new_split:down"
              "ctrl+shift+w=close_surface"
              "ctrl+shift+f=toggle_split_zoom"

              # Navegação
              "ctrl+alt+left=goto_split:left"
              "ctrl+alt+right=goto_split:right"
              "ctrl+alt+up=goto_split:top"
              "ctrl+alt+down=goto_split:bottom"

              # Área de transferência
              "performable:ctrl+c=copy_to_clipboard"
              "ctrl+v=paste_from_clipboard"
            ];
          };

          themes = {
            catppuccin-mocha = {
              background = "1e1e2e";
              cursor-color = "f5e0dc";
              foreground = "cdd6f4";
              palette = [
                "0=#45475a"
                "1=#f38ba8"
                "2=#a6e3a1"
                "3=#f9e2af"
                "4=#89b4fa"
                "5=#f5c2e7"
                "6=#94e2d5"
                "7=#bac2de"
                "8=#585b70"
                "9=#f38ba8"
                "10=#a6e3a1"
                "11=#f9e2af"
                "12=#89b4fa"
                "13=#f5c2e7"
                "14=#94e2d5"
                "15=#a6adc8"
              ];
              selection-background = "353749";
              selection-foreground = "cdd6f4";
            };
          };
        };
      };
    };
}
