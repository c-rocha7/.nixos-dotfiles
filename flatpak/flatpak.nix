{ config, lib, pkgs, ... }:

{
    services.flatpak = 
    {
        enable = true;
        
        update.auto = 
        {
            enable = true;
            onCalendar = "weekly";
        };

        remotes = lib.mkOptionDefault 
        [
            {
                name = "flathub";
                location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
            }
        ];

        packages = [];
    };
}
