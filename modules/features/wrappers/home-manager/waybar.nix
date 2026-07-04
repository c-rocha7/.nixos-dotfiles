{ self, inputs, ... }:

{
  flake.nixosModules.waybar = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        programs.waybar = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.myWaybar;
        };
      };
    };

  perSystem = { pkgs, ... }:
    {
      packages.myWaybar = inputs.wrapper-modules.wrappers.waybar.wrap {
        inherit pkgs;

        settings = {
          height = 30;
          spacing = 5;
          mode = "dock";
          reload_style_on_change = true;
          margin-top = 1;
          margin-left = 1;
          margin-right = 1;

          modules-left = [
            "custom/power"
            "hyprland/workspaces"
            "wlr/taskbar"
            "custom/cava"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "mpris"
            "tray"
            "pulseaudio"
            "custom/swaync"
          ];

          "custom/power" = {
            "format" = "";
            "tooltip" = false;
            "on-click" = "wlogout --buttons-per-row 4";
          };
          "hyprland/workspaces" = {
            "format" = "{}";
            "on-click" = "activate";
            "sort-by-number" = true;
            "on-scroll-up" = "hyprctl dispatch workspace e-1";
            "on-scroll-down" = "hyprctl dispatch workspace e+1";
            "format-icons" = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "10" = "10";
            };
            "persistent-workspaces" = {
              "DP-1" = [ 1 2 3 4 5 ];
              "DP-2" = [ 6 7 8 9 10 ];
            };
          };
          "wlr/taskbar" = {
            "format" = "{icon}";
            "icon-size" = 14;
            "tooltip-format" = "{title}";
            "on-click" = "activate";
            "on-click-middle" = "close";
            "ignore-list" = [ ];
            "tooltip" = false;
          };
          "custom/cava" = {
            "format" = "{}";
            "exec" = "~/.config/waybar/scripts/cava.sh";
          };

          /* Modules Center */
          "clock" = {
            "interval" = 1;
            "format" = " {:%d/%m/%Y | %H:%M:%S}  ";
            "tooltip" = true;
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            "actions" = {
              "on-click-right" = "mode";
              "on-click-forward" = "tz_up";
              "on-click-backward" = "tz_down";
            };
            "calendar" = {
              "mode" = "month";
              "mode-mon-col" = 3;
              "on-scroll" = 1;
              "on-click-right" = "mode";
              "format" = {
                "months" = "<span color='#cba6f7'><b>{}</b></span>";
                "weekdays" = "<span color='#89b4fa'><b>{}</b></span>";
                "today" = "<span color='#cba6f7'><b>{}</b></span>";
              };
            };
          };

          /* Modules Right */
          "mpris" = {
            "format" = "{player_icon} {title} - {artist}";
            "format-paused" = "{status_icon} {title} - {artist}";
            "max-length" = 50;
            "dynamic-len" = 10;
            "player" = "spotify";
            "on-scroll-up" = "playerctl --player=spotify volume 0.05+";
            "on-scroll-down" = "playerctl --player=spotify volume 0.05-";
            "player-icons" = {
              "spotify" = "<span color='#a6e3a1'></span>";
            };
            "status-icons" = {
              "paused" = "⏸";
              "playing" = "";
              "stopped" = "";
            };
            "tooltip" = false;
          };
          "tray" = {
            "icon-size" = 14;
            "spacing" = 10;
            "reverse-direction" = true;
          };
          "pulseaudio" = {
            "format" = "{icon} {volume}% {format_source}";
            "format-muted" = "󰖁 0% {format_source}";
            "format-icons" = {
              "default" = [ "" "" ];
            };
            "scroll-step" = 5;
            "on-click" = "pavucontrol";
            "ignored-sinks" = [ "Easy Effects Sink" ];
            "format-source" = " {volume}%";
            "format-source-muted" = " {volume}%";
            "tooltip" = false;
            "on-click-right" = "amixer sset Master toggle";
          };
          "custom/swaync" = {
            "format" = "";
            "tooltip" = "notification center";
            "on-click" = "swaync-client -t -sw";
            "exec-if" = "which swaync-client";
            "exec" = "swaync-client -swb";
            "format-icons" = {
              "notification" = "󰂚";
              "none" = "󰂚";
              "dnd-notification" = "󰂛";
              "dnd-none" = "󰂛";
              "inhibited-notification" = "󰂚";
              "inhibited-none" = "󰂚";
              "dnd-inhibited-notification" = "󰂛";
              "dnd-inhibited-none" = "󰂛";
            };
            "return-type" = "json";
            "escape" = true;
          };
        };

        "style.css" = {
          content = ''
            * {
              all: unset;
              font-family: "FiraCode Nerd Font Propo";
              font-weight: 600;
              font-size: 14px;
            }

            window#waybar {
              background: transparent;
            }

            #custom-power,
            #workspaces button,
            #taskbar button,
            #clock,
            #mpris,
            #tray,
            #pulseaudio,
            #custom-swaync,
            #custom-cava {
              background: #1e1e2e;
              border-radius: 10px;
              color: #cdd6f4;
            }

            /* Modules Left */
            #custom-power {
              color: #f38ba8;
              padding: 0 10px;
            }

            #custom-power:hover {
              background: #f38ba8;
              color: #1e1e2e;
            }

            #workspaces button {
              color: #cdd6f4;
              min-width: 20px;
              margin-right: 5px;
              padding: 0 8px;
            }

            #workspaces button:last-child {
              margin-right: 0px;
            }

            #workspaces button.active {
              background: #89b4fa;
              color: #1e1e2e;
            }

            #workspaces button:hover {
              background: #45475a;
            }

            #taskbar button {
              margin-right: 5px;
              padding: 0 10px;
            }

            #taskbar button:last-child {
              margin-right: 0px;
            }

            #taskbar button.active {
              background: #89b4fa;
              color: #1e1e2e;
            }

            #taskbar button:hover {
              background: #45475a;
            }

            #custom-cava {
              font-size: 12px;
              letter-spacing: 1px;
              padding: 0 5px;
            }

            /* Modules Center */
            #clock {
              padding: 0 5px 0 10px;
              color: #cba6f7;
            }

            /* Modules Right */
            #mpris {
              padding: 0px 10px;
              color: #a6e3a1;
            }

            #tray {
              padding: 0 10px;
            }

            #pulseaudio {
              padding: 0 10px;
              color: #fab387;
            }

            #custom-swaync {
              padding: 0px 10px;
              color: #74c7ec;
            }

            #custom-swaync:hover {
              background: #74c7ec;
              color: #1e1e2e;
            }
          '';
        };
      };
    };
}
