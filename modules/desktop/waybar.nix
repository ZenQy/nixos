{ pkgs, ... }:

{
  programs.waybar.enable = true;
  environment.etc = {
    "xdg/waybar/config".text =
      let
        conf = {
          layer = "top";
          position = "top";
          height = 30;

          modules-left = [
            # "hyprland/workspaces"
            # "sway/workspaces"
            "niri/workspaces"
          ];

          modules-center = [
            # "hyprland/window"
            # "sway/window"
            "niri/window"
          ];

          modules-right = [
            # "idle_inhibitor"
            # "custom/weather"
            "wireplumber"
            "network"
            "bluetooth"
            "cpu"
            "memory"
            "temperature"
            # "backlight"
            "clock"
            "tray"
          ];

          # "hyprland/workspaces" = {
          #   format = "{icon}";
          #   format-icons = {
          #     "1" = "";
          #     "2" = "";
          #     "3" = "";
          #     "4" = "";
          #     "5" = "";
          #     active = "";
          #     default = "";
          #   };
          #   on-scroll-up = "hyprctl dispatch workspace e-1";
          #   on-scroll-down = "hyprctl dispatch workspace e+1";
          # };

          # "hyprland/window" = {
          #   format = " {}";
          #   rewrite = {
          #     "(.*) - Personal - Microsoft Edge" = "🌎 $1";
          #     "(.*) - Untitled(Workspace) - VSCodium" = " $1";
          #   };
          #   separate-outputs = true;
          #   max-length = 100;
          # };

          # "sway/workspaces" = {
          #   format = "{icon}";
          #   format-icons = {
          #     "1" = "";
          #     "2" = "";
          #     "3" = "";
          #     "4" = "";
          #     "5" = "";
          #     active = "";
          #     default = "";
          #   };
          # };

          # "sway/window" = {
          #   format = " {title}";
          #   max-length = 100;
          #   rewrite = {
          #     "(.*) - Personal - Microsoft Edge" = "🌎 $1";
          #     "(.*) - Untitled\(Workspace\) - VSCodium" = " $1";
          #   };
          # };

          "niri/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              # active = "";
              default = "";
            };
          };

          "niri/window" = {
            format = " {title}";
            max-length = 100;
            rewrite = {
              "(.*) - Personal - Microsoft Edge" = "🌎 $1";
              "(.*) - Untitled\(Workspace\) - VSCodium" = " $1";
            };
          };

          # idle_inhibitor = {
          #   format = "{icon}";
          #   format-icons = {
          #     activated = "";
          #     deactivated = "";
          #   };
          # };

          # "custom/weather" = {
          #   format = "{}";
          #   interval = 60;
          #   escape = true;
          #   exec = "${pkgs.curl}/bin/curl -s 'https://wttr.in/Fengyang?m&format=1'";
          # };

          bluetooth = {
            format = " {status}";
            format-disabled = "";
            format-connected = " {device_alias}";
            format-connected-battery = " {device_alias} {device_battery_percentage}%";
            format-device-preference = [
              ""
              ""
              ""
            ];
          };

          wireplumber = {
            format = "{volume}% {icon}";
            format-muted = "";
            format-icons = [
              ""
              ""
              ""
            ];
            on-click = "${pkgs.helvum}/bin/helvum";
            max-volume = 100.0;
            scroll-step = 1.0;
          };

          network = {
            format-wifi = "{essid} ";
            format-ethernet = "{ifname} ";
            format-disconnected = "";
          };

          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };

          memory = {
            format = "{}% ";
          };

          temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = [
              ""
              ""
              ""
            ];
            interval = 10;
            thermal-zone = 1;
          };

          # backlight = {
          #   format = "{percent}% {icon}";
          #   format-icons = [ "" "" ];
          #   on-scroll-down = "brightnessctl set 3%-";
          #   on-scroll-up = "brightnessctl set +3%";
          # };

          clock = {
            format = "{:%H:%M} ";
            format-alt = "{:%Y-%m-%d} ";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
          };

          tray = {
            icon-size = 25;
            spacing = 10;
          };

        };
      in
      builtins.toJSON conf;
    "xdg/waybar/style.css".source = ./dotfiles/waybar/style.css;
  };
}
