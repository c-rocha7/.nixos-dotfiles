# NixOS Modular com Flakes + Home Manager

Repositorio de configuracao NixOS modular, com foco em:

- organizacao por responsabilidade (kernel, boot, desktop, rede, usuario, etc.);
- integracao com Home Manager;
- uso de canais estavel e unstable no mesmo sistema;
- suporte a Secure Boot via Lanzaboote.

## Visao geral

A entrada principal do sistema e o arquivo `flake.nix`, que monta a configuracao `nixosConfigurations.nixos`.

Fluxo de composicao:

1. `flake.nix` importa `configuration.nix`;
2. `configuration.nix` importa os modulos de sistema por pasta;
3. `home.nix` importa os modulos de usuario e programas;
4. cada pasta `default.nix` agrega os arquivos daquela area.

## Inputs do flake

Definidos em `flake.nix`:

- `nixpkgs` (canal estavel `nixos-26.05`)
- `nixpkgs-unstable`
- `home-manager` (`release-26.05`)
- `lanzaboote` (Secure Boot)
- `nix-flatpak`
- `zen-browser`

Tambem existe overlay `unstable` para expor `pkgs.unstable`.

## Modulos ativos atualmente

Com base nas importacoes atuais:

- Kernel: `linuxPackages_zen` + parametro `kernel.split_lock_mitigate=0`
- CPU/GPU AMD: driver `amdgpu`, ROCm ICD e cache de shader ajustado
- Swap: zram habilitado com limite de 8 GiB
- Boot: Secure Boot com Lanzaboote (`bootloaders/secure-boot.nix`)
- Rede: NetworkManager, firewall ligado, locale `pt_BR.UTF-8`, timezone `America/Sao_Paulo`
- Desktop: SDDM + Plasma 6, PipeWire, impressao, teclado BR/ABNT2, UPower
- Flatpak: habilitado com remote Flathub e update semanal automatico
- Virtualizacao/containers: libvirtd + virt-manager + podman (dockerCompat)
- Usuario: `cauanixos` com shell `zsh` e grupos `wheel`, `networkmanager`, `libvirtd`
- Home Manager: modulos de terminal, git, zsh, fzf, dev-tools, obs-studio e fastfetch

## Estrutura do repositorio

```text
.
├── .editorconfig
├── README.md
├── flake.lock
├── flake.nix
├── configuration.nix
├── hardware-configuration.nix
├── home.nix
├── amd
│   ├── amd-cpu.nix
│   ├── amd-gpu.nix
│   └── default.nix
├── bootloaders
│   ├── default.nix
│   ├── grub.nix
│   ├── limine.nix
│   ├── secure-boot.nix
│   └── systemd-boot.nix
├── desktop
│   ├── audio-pipewire.nix
│   ├── default.nix
│   ├── dm-gdm.nix
│   ├── dm-sddm.nix
│   ├── fonts.nix
│   ├── printing.nix
│   ├── teclado-br.nix
│   ├── upower.nix
│   ├── wm-gnome.nix
│   └── wm-plasma6.nix
├── flatpak
│   ├── default.nix
│   └── flatpak.nix
├── init-default-desktops
│   ├── budgie
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   ├── cinnamon
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   ├── gnome
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   ├── lxqt
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   ├── mate
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   ├── patheon
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   ├── plasma
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   └── xfce
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── kernel-params
│   ├── default.nix
│   └── kernel-params.nix
├── modules
│   ├── default.nix
│   ├── dev-tools.nix
│   ├── fzf.nix
│   ├── git.nix
│   ├── obs-studio.nix
│   ├── terminal.nix
│   └── zsh.nix
├── network
│   ├── default.nix
│   └── firewall.nix
├── nix-settings
│   ├── default.nix
│   ├── kvm.nix
│   ├── nix-settings.nix
│   └── podman.nix
├── programs
│   └── fastfetch
│       ├── default.nix
│       └── NixOS.png
├── user
│   ├── cauanixos.nix
│   └── default.nix
└── zram
    ├── default.nix
    └── zram.nix
```

## O que cada pasta faz

- `amd/`: parametros e habilitacao para hardware AMD (CPU e GPU).
- `bootloaders/`: alternativas de bootloader (GRUB, systemd-boot, Limine) e Secure Boot.
- `desktop/`: stack grafica, audio, fontes, display manager e desktop environment.
- `flatpak/`: configuracao declarativa do Flatpak.
- `init-default-desktops/`: templates completos de instalacao inicial para varios desktops.
- `kernel-params/`: escolha do kernel e parametros de boot.
- `modules/`: modulos de Home Manager para ambiente de usuario.
- `network/`: hostname, locale, timezone, rede e firewall.
- `nix-settings/`: opcoes globais do Nix/Nixpkgs e virtualizacao/containers.
- `programs/fastfetch/`: tema/config do fastfetch incluindo logo customizado.
- `user/`: declaracao do usuario do sistema e pacotes de sistema basicos.
- `zram/`: configuracao de zram swap.

## Como aplicar a configuracao

No diretorio raiz do repositorio:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

Alternativas:

```bash
sudo nixos-rebuild boot --flake .#nixos
sudo nixos-rebuild test --flake .#nixos
```

## Notas

- `home-manager` esta integrado via modulo NixOS no proprio `flake.nix`.
- O boot ativo no estado atual privilegia `lanzaboote` (Secure Boot).
- Os arquivos em `init-default-desktops/` funcionam como base/template e nao sao importados automaticamente por `configuration.nix`.
