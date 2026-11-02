{ ... }:

{
  flake.nixosModules.dev = { pkgs, ... }:
    {
      home-manager.users."7aauac" = { config, ... }: {
        home.packages = with pkgs.unstable; [
          devenv

          (lib.lowPrio pkgs.navicat-premium) # stable: 18.x do unstable não abre

          gcc
          gnumake
          pkg-config
          autoconf
          bison
          re2c

          readline
          readline.dev
          openssl.out
          openssl.dev
          zlib
          zlib.dev
          libzip
          libzip.dev
          curl.out
          curl.dev
          sqlite.out
          sqlite.dev
          libpng
          libpng.dev
          freetype
          freetype.dev
          libjpeg.out
          libjpeg.dev
          libwebp
          libsodium
          libsodium.dev
          gmp
          gmp.dev
          libxml2.out
          libxml2.dev
          oniguruma
          oniguruma.lib
          oniguruma.dev
          icu
          icu.dev
          gettext
        ];

        home.sessionVariables = {
          PKG_CONFIG_PATH = "${config.home.profileDirectory}/lib/pkgconfig:${config.home.profileDirectory}/share/pkgconfig";
        };

        programs.vscode = {
          enable = true;
          package = pkgs.unstable.vscode;
        };

        programs.direnv = {
          enable = true;
          package = pkgs.unstable.direnv;
          enableZshIntegration = true;

          nix-direnv = {
            enable = true;
            package = pkgs.unstable.nix-direnv;
          };
        };
      };
    };
}
