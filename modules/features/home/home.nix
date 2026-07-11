{ inputs, ... }:

{
  flake.nixosModules.home = { ... }:
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        backupFileExtension = "backup";

        users.cauanixos = { config, ... }: {
          home.username = "cauanixos";
          home.homeDirectory = "/home/cauanixos";
          home.stateVersion = "26.05";

          home.packages = [ ];

          programs.home-manager.enable = true;

          xdg = {
            mimeApps = {
              enable = true;
              defaultApplications = {
                "inode/directory" = [ "thunar.desktop" ];
                "text/html" = [ "zen.desktop" ];
                "x-scheme-handler/http" = [ "zen.desktop" ];
                "x-scheme-handler/https" = [ "zen.desktop" ];
                "x-scheme-handler/about" = [ "zen.desktop" ];
                "x-scheme-handler/unknown" = [ "zen.desktop" ];
                "video/mp4" = [ "mpv.desktop" ];
                "video/x-matroska" = [ "mpv.desktop" ];
                "video/webm" = [ "mpv.desktop" ];
                "video/quicktime" = [ "mpv.desktop" ];
                "video/x-msvideo" = [ "mpv.desktop" ];
                "audio/mpeg" = [ "mpv.desktop" ];
                "audio/flac" = [ "mpv.desktop" ];
                "audio/ogg" = [ "mpv.desktop" ];
                "audio/wav" = [ "mpv.desktop" ];
                "image/png" = [ "qview.desktop" ];
                "image/jpeg" = [ "qview.desktop" ];
                "image/jpg" = [ "qview.desktop" ];
                "image/webp" = [ "qview.desktop" ];
                "image/gif" = [ "qview.desktop" ];
                "image/bmp" = [ "qview.desktop" ];
              };
            };

            userDirs = {
              enable = true;
              createDirectories = true;

              download = "${config.home.homeDirectory}/Downloads";
              documents = "${config.home.homeDirectory}/Documentos";
              desktop = "${config.home.homeDirectory}/Área de Trabalho";
              pictures = "${config.home.homeDirectory}/Imagens";
              videos = "${config.home.homeDirectory}/Vídeos";
              music = "${config.home.homeDirectory}/Música";
              publicShare = "${config.home.homeDirectory}/Público";
              templates = "${config.home.homeDirectory}/Modelos";
            };
          };

          services.gnome-keyring.enable = true;
        };
      };
    };
}
