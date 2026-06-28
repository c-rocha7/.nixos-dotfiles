{ self, inputs, ... }:

{
  flake.nixosModules.homeTerminal = { config, lib, pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          tree
          zsh-powerlevel10k
        ];

        programs.bat.enable = true;
        programs.btop.enable = true;
        programs.cava.enable = true;
        programs.eza.enable = true;
        programs.fastfetch.enable = true;

        programs.kitty = {
          enable = true;
          font = {
            name = "FiraCode Nerd Font";
            size = 12.0;
          };
          settings = {
            bold_font = "auto";
            italic_font = "auto";
            bold_italic_font = "auto";

            shell = "${pkgs.zsh}/bin/zsh";

            allow_remote_control = "yes";

            foreground = "#cdd6f4";
            background = "#1e1e2e";
            selection_foreground = "#1e1e2e";
            selection_background = "#f5e0dc";
            cursor = "#f5e0dc";
            cursor_text_color = "#1e1e2e";

            color0 = "#45475a";
            color1 = "#f38ba8";
            color2 = "#a6e3a1";
            color3 = "#f9e2af";
            color4 = "#89b4fa";
            color5 = "#f5c2e7";
            color6 = "#94e2d5";
            color7 = "#bac2de";

            color8 = "#585b70";
            color9 = "#f38ba8";
            color10 = "#a6e3a1";
            color11 = "#f9e2af";
            color12 = "#89b4fa";
            color13 = "#f5c2e7";
            color14 = "#94e2d5";
            color15 = "#a6adc8";

            window_padding_width = 5;
          };
        };

        programs.fzf = {
          enable = true;
          enableZshIntegration = true;
          enableBashIntegration = true;

          defaultOptions = [
            "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
          ];
        };

        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;

          plugins = [
            {
              name = "powerlevel10k";
              src = pkgs.zsh-powerlevel10k;
              file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
          ];

          initContent = ''
            # Enable Powerlevel10k instant prompt (opcional, mas deixa o terminal bem mais rápido)
            if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
              source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi

            # Carrega as configurações visuais do p10k (geradas pelo p10k configure)
            [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
          '';

          oh-my-zsh = {
            enable = true;
          };

          history = {
            size = 10000;
            save = 10000;
            share = true;
            ignoreDups = true;
          };

          shellAliases = {
            ".." = "cd ..";
            "..." = "cd ../..";
            ls = "eza --icons --group-directories-first";
            ll = "eza -l --icons --group-directories-first";
            la = "ls -a";
            bat = "bat --style=auto";
            ff = "fastfetch";
            nrsd = "sudo nixos-rebuild switch --flake ~/.nixos-dotfiles#desktop";
            nrbd = "sudo nixos-rebuild boot --flake ~/.nixos-dotfiles#desktop";
          };
        };
      };
    };
}
