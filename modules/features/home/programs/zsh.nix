{ ... }:

{
  flake.nixosModules.zsh = { pkgs, ... }:
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

            # Remove o arquivo de persistência e desativa opções de histórico do Oh-My-Zsh
            unset HISTFILE
            unsetopt share_history
            unsetopt append_history
            unsetopt inc_append_history

            # Ativação do Mise (verifica se o binário existe antes de rodar)
            if [[ -f "$HOME/.local/bin/mise" ]]; then
              eval "$($HOME/.local/bin/mise activate zsh)"
              eval "$($HOME/.local/bin/mise completion zsh)"
            fi
          '';

          oh-my-zsh = {
            enable = true;
          };

          history = {
            size = 10000;
            save = 0;
            path = "/dev/null";
            share = false;
          };

          shellAliases = {
            ".." = "cd ..";
            "..." = "cd ../..";
            ls = "eza --icons --group-directories-first";
            ll = "eza -l --icons --group-directories-first";
            la = "ls -a";
            bat = "bat --style=auto";
            ff = "fastfetch";

            /* Desktop */
            nrsfd = "sudo nixos-rebuild switch --flake ~/.nixos-dotfiles#desktop";
            nrbfd = "sudo nixos-rebuild boot --flake ~/.nixos-dotfiles#desktop";

            /* Laptop */
            nrsfl = "sudo nixos-rebuild switch --flake ~/.nixos-dotfiles#laptop";
            nrbfl = "sudo nixos-rebuild boot --flake ~/.nixos-dotfiles#laptop";

            /* Nix Flake Update */
            nfu = "sudo nix flake update --flake ~/.nixos-dotfiles";

            /* Distrobox */
            arch = "distrobox enter arch";
          };
        };
      };
    };
}
