{ pkgs, config, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Monitores
      monitor = [
        "DP-1,1920x1080@239.96,0x0,1"
        "DP-2,1920x1080@239.96,-1920x0,1"
      ];

      # Programas Padrão
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show drun -disable-history";

      # Autostart (exec-once)
      "exec-once" = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "kbuildsycoca6"
        "nm-applet --indicator"
        "waybar"
        "swaync"
        "swww init"
        "waypaper --restore"
        "wl-paste --type text --watch clipvault store"
        "wl-paste --type image --watch clipvault store"
        # Polkit do NixOS geralmente fica em um caminho diferente:
        "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];

      # Input
      input = {
        kb_layout = "us";
        kb_variant = "alt-intl";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = false;
      };

      windowrule = [
        "float,class:(.*org.pulseaudio.pavucontrol.*)"
        "size 800 700,class:(.*org.pulseaudio.pavucontrol.*)"
        "center,class:(.*org.pulseaudio.pavucontrol.*)"
        "float,class:(.*org.gnome.Calculator.*)"
        "float,class:(.*io.missioncenter.MissionCenter.*)"
      ];

      # Atalhos de Teclado (Binds)
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo," 
        "$mainMod, J, togglesplit,"
        "$mainMod, V, togglefloating,"
        
        # Foco
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
      ];

      # Movimentação de janelas com mouse
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
