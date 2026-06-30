{ ... }:

{
  flake.nixosModules.nixLd = { pkgs, ... }:
    {
      programs.nix-ld = {
        enable = true;

        libraries = with pkgs; [
          # --- 1. ÁUDIO E MULTIMÍDIA ---
          alsa-lib
          libpulseaudio
          pipewire

          # --- 2. GRÁFICOS E ACELERAÇÃO DE HARDWARE ---
          mesa
          libGL
          libdrm
          libva
          libvdpau

          # --- 3. SERVIDORES DE TELA (X11 & WAYLAND) ---
          wayland
          libxkbcommon
          libx11
          libxscrnsaver
          libxcomposite
          libxcursor
          libxdamage
          libxext
          libxfixes
          libxi
          libxrandr
          libxrender
          libxtst
          libxcb
          xrandr

          # --- 4. INTERFACE GRÁFICA, FONTES E ACESSIBILIDADE ---
          gtk3
          cairo
          pango
          fontconfig
          freetype
          gdk-pixbuf
          libappindicator-gtk3
          at-spi2-atk
          at-spi2-core
          atk

          # --- 5. SISTEMA, REDE E UTILITÁRIOS BASE ---
          systemd
          dbus
          fuse3
          curl
          cups
          glib
          icu
          expat
          zlib
          nss
          nspr
          capnproto
          libidn2
          libusb1
          libuuid
          libxml2
        ];
      };
    };
}
