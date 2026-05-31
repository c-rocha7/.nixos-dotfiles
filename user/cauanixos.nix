{ config, pkgs, ... }:

{
    users.users.cauanixos = 
    {
        isNormalUser = true;

        extraGroups = 
        [
            "wheel"
            "networkmanager"
            "libvirtd"
        ];

        packages = with pkgs; [];
    };

    environment.systemPackages = with pkgs;
    [
        vim
        wget
        micro
    ];
}
