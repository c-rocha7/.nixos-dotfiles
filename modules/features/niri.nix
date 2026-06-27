{ self, inputs, ... }:

{
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;

        v2-settings = true;

        settings = {
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          prefer-no-csd = _: { };

          input = {
            keyboard = {
              repeat-rate = 35;
              repeat-delay = 200;

              xkb = {
                layout = "br";
              };

              numlock = _: { };
            };

            touchpad = {
              accel-speed = 0;
              accel-profile = "flat";
            };

            mouse = {
              accel-speed = 0;
              accel-profile = "flat";
            };

            trackpoint = {
              accel-speed = 0;
              accel-profile = "flat";
            };

            focus-follows-mouse = _: {
              props = {
                max-scroll-amount = "0%";
              };
            };
          };

          outputs = {
            "DP-1" = {
              mode = "1920x1080@239.964";
              position = _: {
                props = {
                  x = 0;
                  y = 0;
                };
              };
            };

            "DP-2" = {
              mode = "1920x1080@239.964";
              position = _: {
                props = {
                  x = -1920;
                  y = 0;
                };
              };
            };
          };

          layout = {
            gaps = 16;
            center-focused-column = "never";

            preset-column-widths = [
              { proportion = 0.33333; }
              { proportion = 0.5; }
              { proportion = 0.66667; }
            ];

            default-column-width = [
              { proportion = 0.5; }
            ];

            focus-ring = {
              width = 4;
              active-color = "#7fc8ff";
              inactive-color = "#505050";
            };

            border = {
              off = _: { };
              width = 4;
              active-color = "#ffc87f";
              inactive-color = "#505050";
              urgent-color = "#9b0000";
            };

            shadow = {
              softness = 30;
              spread = 5;
              offset = _: {
                props = {
                  x = 0;
                  y = 5;
                };
              };

              color = "#0007";
            };

            struts = {
              # top = 0;
              # bottom = 0;
              # left = 0;
              # right = 0;
            };
          };

          # spawn-at-startup = [
          #   (lib.getExe self'.packages.noctalia-shell)
          #   ("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
          #   ("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
          # ];

          spawn-at-startup = [
            (lib.getExe self'.packages.noctalia-shell)

            [ 
              "dbus-update-activation-environment" 
              "--systemd" 
              "WAYLAND_DISPLAY" 
              "XDG_CURRENT_DESKTOP" 
            ]

            [ 
              "systemctl" 
              "--user" 
              "import-environment" 
              "WAYLAND_DISPLAY" 
              "XDG_CURRENT_DESKTOP" 
            ]
          ];

          # hotkey-overlay = { };

          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

          # animations = { };

          window-rule = [
            {
              match = [
                # {
                #   app-id = "$#'firefox$'#";
                #   title = "^Picture-in-Picture$";
                #   open-floating = true;
                # }
                # {
                #   app-id = "r#'^org\.keepassxc\.KeePassXC$'#";
                #   block-out-from = "screen-capture";
                # }
                # {
                #   app-id = "r#'^org\.gnome\.World\.Secrets$'#";
                #   block-out-from = "screen-capture";
                # }
              ];
              geometry-corner-radius = 12;
              clip-to-geometry = true;
            }
          ];

          binds = {
            "Mod+Shift+Slash" = { show-hotkey-overlay = _: { }; };

            "Mod+T".spawn-sh = lib.getExe pkgs.kitty;

            # "Mod+S".spawn-sh = "${lib.getExe self'.packages.noctalia-shell} ipc call launcher toggle";

            "Mod+Space".spawn-sh = lib.getExe pkgs.fuzzel;

            "Mod+Shift+Ctrl+S".spawn-sh = "nix run nixpkgs#noctalia-shell ipc call state all > ~/.nixos-dotfiles/modules/features/noctalia.json";

            "Mod+Q".close-window = _: { };
            "Mod+F".maximize-column = _: { };
            "Mod+Shift+F".fullscreen-window = _: { };
            "Mod+Shift+S".toggle-window-floating = _: { };
            "Mod+C".center-column = _: { };

            "Mod+O".toggle-overview = _: { };

            "Mod+H".focus-column-left = _: { };
            "Mod+L".focus-column-right = _: { };
            "Mod+K".focus-window-up = _: { };
            "Mod+J".focus-window-down = _: { };

            "Mod+Left".focus-column-left = _: { };
            "Mod+Right".focus-column-right = _: { };
            "Mod+Up".focus-window-up = _: { };
            "Mod+Down".focus-window-down = _: { };

            "Mod+Shift+H".move-column-left = _: { };
            "Mod+Shift+L".move-column-right = _: { };
            "Mod+Shift+K".move-window-up = _: { };
            "Mod+Shift+J".move-window-down = _: { };

            "Mod+Shift+Left".move-column-left = _: { };
            "Mod+Shift+Right".move-column-right = _: { };
            "Mod+Shift+Up".move-window-up = _: { };
            "Mod+Shift+Down".move-window-down = _: { };

            "Mod+1" = { focus-workspace = 1; };
            "Mod+2" = { focus-workspace = 2; };
            "Mod+3" = { focus-workspace = 3; }; 
            "Mod+4" = { focus-workspace = 4; };
            "Mod+5" = { focus-workspace = 5; }; 
            "Mod+6" = { focus-workspace = 6; };
            "Mod+7" = { focus-workspace = 7; }; 
            "Mod+8" = { focus-workspace = 8; };
            "Mod+9" = { focus-workspace = 9; };
            "Mod+0" = { focus-workspace = 10; };

            "Mod+Ctrl+1" = { move-column-to-workspace = 1; };
            "Mod+Ctrl+2" = { move-column-to-workspace = 2; };
            "Mod+Ctrl+3" = { move-column-to-workspace = 3; };
            "Mod+Ctrl+4" = { move-column-to-workspace = 4; };
            "Mod+Ctrl+5" = { move-column-to-workspace = 5; };
            "Mod+Ctrl+6" = { move-column-to-workspace = 6; };
            "Mod+Ctrl+7" = { move-column-to-workspace = 7; };
            "Mod+Ctrl+8" = { move-column-to-workspace = 8; };
            "Mod+Ctrl+9" = { move-column-to-workspace = 9; };
            "Mod+Ctrl+0" = { move-column-to-workspace = 10; };

            "Mod+Ctrl+H".set-column-width = "-5%";
            "Mod+Ctrl+L".set-column-width = "+5%";
            "Mod+Ctrl+J".set-window-height = "-5%";
            "Mod+Ctrl+K".set-window-height = "+5%";

            "Mod+Ctrl+Left".set-column-width = "-5%";
            "Mod+Ctrl+Right".set-column-width = "+5%";
            "Mod+Ctrl+Up".set-window-height = "-5%";
            "Mod+Ctrl+Down".set-window-height = "+5%";

            "Mod+Shift+E"     = { quit = _: { }; };
            "Ctrl+Alt+Delete" = { quit = _: { }; };

            "Print"      = { screenshot = _: { }; };
            "Ctrl+Print" = { screenshot-screen = _: { }; };
            "Alt+Print"  = { screenshot-window = _: { }; };

            # "Mod+WheelScrollDown".focus-column-left = null;
            # "Mod+WheelScrollUp".focus-column-right = null;
            # "Mod+Ctrl+WheelScrollDown".focus-workspace-down = null;
            # "Mod+Ctrl+WheelScrollUp".focus-workspace-up = null;

            "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
            "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1- -l 1.0";
            "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "XF86AudioMicMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

            "XF86AudioPlay".spawn-sh = "playerctl play-pause";
            "XF86AudioPause".spawn-sh = "playerctl play-pause";
            "XF86AudioStop".spawn-sh = "playerctl stop";
            "XF86AudioPrev".spawn-sh = "playerctl previous";
            "XF86AudioNext".spawn-sh = "playerctl next";

            "XF86MonBrightnessUp".spawn-sh = "brightnessctl set +10%";
            "XF86MonBrightnessDown".spawn-sh = "brightnessctl set 10%-";
          };
        };
      };
    };
}
