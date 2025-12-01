{ pkgs, ... }:

let
  colors = [
    "#69ff94" # green
    "#2aa9ff" # blue
    "#f8f8f2" # white
    "#ffffa5" # yellow
    "#ff9977" # orange
    "#dd532e" # red
  ];

  conf = {
    layer = "top";
    position = "top";

    modules-left = [
      # "hyprland/workspaces"
      # "sway/workspaces"
      "custom/power"
      "custom/lock"

      "niri/workspaces"
    ];

    modules-center = [
      # "hyprland/window"
      # "sway/window"
      "niri/window"
    ];

    modules-right = [
      "wireplumber"
      "cpu"
      "memory"
      "temperature"
      "clock"

      "bluetooth"
      "network"

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
      swap-icon-label = true;
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
      format = " {status}";
      format-disabled = "";
      format-connected = " x{num_connections}";
      tooltip-format = " {device_alias} {device_battery_percentage}%";
    };

    wireplumber = {
      format = "{icon} {volume}";
      format-muted = "🔇";
      format-icons = [
        ""
        ""
        ""
      ];
      on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      on-click-right = "${pkgs.helvum}/bin/helvum";
      max-volume = 100.0;
      scroll-step = 1.0;
    };

    network = {
      format-wifi = "";
      format-ethernet = "";
      format-disconnected = "";
      tooltip-format-wifi = "{essid} ({signalStrength}%)";
      tooltip-format-ethernet = "{ifname}";
    };

    cpu = {
      format = "{icon} {0}%";
      format-icons = map (color: "<span color='${color}'></span>") colors;
      tooltip = false;
    };

    memory = {
      format = "{icon} {0}%";
      format-icons = map (color: "<span color='${color}'></span>") colors;
    };

    temperature = {
      critical-threshold = 80;
      format = "{icon} {temperatureC}°C";
      format-icons = map (color: "<span color='${color}'></span>") colors;
      format-critical = "";
      interval = 30;
      thermal-zone = 1;
      tooltip = false;
    };

    clock = {
      format = " {:%H:%M}";
      format-alt = " {:%Y-%m-%d}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
    };

    tray = {
      icon-size = 25;
      spacing = 10;
    };

    "custom/lock" = {
      tooltip = false;
      on-click = "${pkgs.swaylock}/bin/swaylock -C /etc/swaylock/config";
      format = "";
    };

    "custom/power" = {
      tooltip = false;
      on-click = "poweroff";
      format = "";
    };

  };

in
{
  programs.waybar.enable = true;
  environment.etc = {
    "xdg/waybar/config".source = (pkgs.formats.json { }).generate "config" conf;
    "xdg/waybar/style.css".source = ./dotfiles/waybar/style.css;
  };
}
