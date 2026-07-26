{ ... }:

{
  flake.nixosModules.xdg = { ... }:
    {
      home-manager.users.cauanixos = { config, ... }:
        {
          xdg = {
            mimeApps = {
              enable = true;
              defaultApplications = {
                /* File Explore */
                "inode/directory" = [ "thunar.desktop" ];

                /* Web */
                "text/html" = [ "zen.desktop" ];
                "x-scheme-handler/http" = [ "zen.desktop" ];
                "x-scheme-handler/https" = [ "zen.desktop" ];
                "x-scheme-handler/about" = [ "zen.desktop" ];
                "x-scheme-handler/unknown" = [ "zen.desktop" ];

                /* Videos */
                "video/mp4" = [ "mpv.desktop" ];
                "video/x-matroska" = [ "mpv.desktop" ];
                "video/webm" = [ "mpv.desktop" ];
                "video/quicktime" = [ "mpv.desktop" ];
                "video/x-msvideo" = [ "mpv.desktop" ];

                /* Audio */
                "audio/mpeg" = [ "mpv.desktop" ];
                "audio/flac" = [ "mpv.desktop" ];
                "audio/ogg" = [ "mpv.desktop" ];
                "audio/wav" = [ "mpv.desktop" ];

                /* Images */
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

              desktop = "${config.home.homeDirectory}/Área de Trabalho";
              documents = "${config.home.homeDirectory}/Documentos";
              download = "${config.home.homeDirectory}/Downloads";
              pictures = "${config.home.homeDirectory}/Imagens";
              templates = "${config.home.homeDirectory}/Modelos";
              music = "${config.home.homeDirectory}/Música";
              projects = "${config.home.homeDirectory}/Projetos";
              publicShare = "${config.home.homeDirectory}/Público";
              videos = "${config.home.homeDirectory}/Vídeos";
            };
          };
        };
    };
}
