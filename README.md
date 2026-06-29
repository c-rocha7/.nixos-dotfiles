# .nixos-dotfiles

Configuração NixOS pessoal baseada em [flake-parts](https://github.com/hercules-ci/flake-parts) e
[import-tree](https://github.com/vic/import-tree), com suporte planejado para múltiplos hosts.

## Estrutura dos módulos

Todos os módulos ficam em `modules/` e são carregados automaticamente pelo `import-tree`.
Cada arquivo expõe um fragmento de flake via `flake-parts`, tipicamente como `flake.nixosModules.<nome>`.

```
modules/
├── parts.nix                  # Configuração global do flake-parts (systems)
├── features/
│   ├── nixos/                 # Módulos NixOS reutilizáveis (feature flags)
│   │   ├── base.nix           # nixosBase    — locale, rede, áudio, nix settings
│   │   ├── desktop.nix        # nixosDesktop — gráficos, SDDM, KDE Plasma, fontes
│   │   ├── overlays.nix       # nixosOverlays — overlay do nixpkgs-unstable
│   │   ├── steam.nix          # nixosSteam   — Steam + gamemode
│   │   └── user-cauanixos.nix # nixosUserCauanixos — definição do usuário do sistema
│   └── home/                  # Módulos home-manager reutilizáveis
│       ├── home.nix           # homeShared   — infraestrutura base do home-manager
│       ├── profiles/          # Perfis agregados de home-manager
│       │   ├── common.nix     # homeCommon      — ferramentas CLI do dia a dia
│       │   ├── dev.nix        # homeDev         — ferramentas de desenvolvimento
│       │   ├── desktop-apps.nix # homeDesktopApps — apps desktop (browser, cava, etc.)
│       │   └── gaming.nix     # homeGaming      — apps de jogos (Heroic, etc.)
│       └── programs/          # Configuração individual de cada programa
│           ├── bat.nix        # homeBat
│           ├── browser.nix    # homeBrowser
│           ├── btop.nix       # homeBtop
│           ├── cava.nix       # homeCava
│           ├── code.nix       # homeCode
│           ├── eza.nix        # homeEza
│           ├── fastfetch.nix  # homeFastfetch
│           ├── fzf.nix        # homeFzf
│           ├── git.nix        # homeGit
│           ├── heroic.nix     # homeHeroic
│           ├── kitty.nix      # homeKitty
│           ├── obsidian.nix   # homeObsidian
│           ├── spotify-player.nix # homeSpotifyPlayer
│           ├── vesktop.nix    # homeVesktop
│           ├── vim.nix        # homeVim
│           └── zsh.nix        # homeZsh
└── hosts/
    ├── desktop/               # Host desktop (ativo)
    │   ├── default.nix        # nixosConfigurations.desktop — composição do host
    │   ├── identity.nix       # desktopIdentity    — hostname
    │   ├── configuration.nix  # desktopConfiguration — boot, drivers, serviços, flatpak
    │   ├── hardware.nix       # desktopHardware    — gerado por nixos-generate-config
    │   └── storage.nix        # desktopStorage     — filesystems extras e zram
    └── laptop/
        └── default.nix        # Esqueleto para futuro host laptop (sem hardware real ainda)
```

## Como os hosts são compostos

Cada host define `flake.nixosConfigurations.<host>` em `modules/hosts/<host>/default.nix`.
A composição segue a ordem:

1. **Inputs externos** — `home-manager`, `nix-flatpak`
2. **nixosOverlays** — overlay do `nixpkgs-unstable` como `pkgs.unstable`
3. **Módulos de features compartilhados** — `nixosBase`, `nixosDesktop`, `nixosSteam`, `nixosUserCauanixos`
4. **Módulos específicos do host** — identity, configuration, hardware, storage
5. **Perfis de home-manager** — `homeCommon`, `homeDev`, `homeDesktopApps`, `homeGaming`

## Módulos expostos via `flake.nixosModules`

Todos os módulos ficam disponíveis como `self.nixosModules.<nome>` e podem ser
reutilizados em qualquer `nixosSystem`. Os nomes seguem dois prefixos:

| Prefixo    | Tipo                                      |
|------------|-------------------------------------------|
| `nixos*`   | Módulos NixOS de features compartilhadas  |
| `home*`    | Módulos home-manager                      |
| `desktop*` | Módulos específicos do host `desktop`     |
| `laptop*`  | Módulos específicos do futuro host `laptop` |

## Suporte a múltiplos hosts

A separação em `modules/hosts/<host>/` isola cada host completamente.
Os módulos em `modules/features/` são compartilhados e não dependem de nenhum host específico.

Para adicionar um novo host (ex.: `laptop`):
1. Crie os arquivos em `modules/hosts/laptop/` (identity, hardware, storage, configuration, default)
2. Em `default.nix`, monte `flake.nixosConfigurations.laptop` importando os módulos compartilhados
   relevantes e os módulos específicos do laptop
3. Não altere `modules/hosts/desktop/`

## O que ainda é específico deste setup

Alguns pontos permanecem intencionalmente acoplados ao setup atual e **não estão generalizados**:

- **Nome de usuário** (`cauanixos`): hardcoded em `nixosUserCauanixos` e em `homeShared`.
  Remover esse acoplamento exigiria um sistema de opções NixOS customizadas — não implementado
  intencionalmente para manter a simplicidade.
- **Paths de storage** (`/home/cauanixos/Discos/...`): específicos do hardware do desktop,
  não faz sentido generalizar.
- **Drivers AMD** (`amdgpu`, `hardware.cpu.amd`): específicos do hardware do desktop.
- **`system.stateVersion`**: definida em `desktopConfiguration` para o desktop.
  Cada host futuro deverá definir a sua própria.
