{ ... }:

{
  flake.nixosModules.homeZsh = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        home.packages = with pkgs; [
          tree
          zsh-powerlevel10k
        ];

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

            # Atalhos de teclado (Keybindings)
            bindkey "^[[H" beginning-of-line
            bindkey "^[[F" end-of-line
            bindkey "^[[3~" delete-char
            bindkey "^H" backward-kill-word
            bindkey "^[[3;5~" kill-word
            bindkey "^[[1;5D" backward-word
            bindkey "^[[1;5C" forward-word
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
