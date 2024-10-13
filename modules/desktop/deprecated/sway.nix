{ lib, pkgs, ... }:
with builtins;

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "nixos";
      };
      default_session = initial_session;
    };
  };

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock
    ];
    xwayland.enable = false;
  };

  environment.etc = {
    "sway/config".text =
      let
        set = {
          mod = "Mod4";
          term = "foot";
          left = "h";
          down = "j";
          up = "k";
          right = "l";
          menu = "${pkgs.fuzzel}/bin/fuzzel";
          screenshot = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" $HOME/Pictures/$(date +\"%F_%T\").png";
          lock = "swaylock -C /etc/swaylock/config";
          exit = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
        };
        bindsym = {
          Return = "exec $term";
          b = "splith";
          v = "splitv";
          s = "layout stacking";
          w = "layout tabbed";
          e = "layout toggle split";
          f = "fullscreen";
          space = "focus mode_toggle";
          a = "focus parent";
          minus = "scratchpad show";
          Scroll_Lock = "exec $lock";
          Print = "exec $screenshot";
          d = "exec $menu";
        };
        bindsymShift = {
          space = "floating toggle";
          minus = "move scratchpad";
          q = "kill";
          c = "reload";
          e = "$exit";
        };
        app_id = {
          foot = 1;
          chromium-browser = 2;
          pcmanfm = 3;
          xarchiver = 3;
          code-url-handler = 4;
          lapce = 4;
          mpv = 5;
          "org.telegram.desktop" = 5;
          sqlitebrowser = 5;
        };
        class = {
          Pcmanfm = 3;
          Code = 4;
          Microsoft-edge = 2;
          Chromium-browser = 2;
          Logseq = 4;
        };
        conf = set: f: concatStringsSep "\n" (attrValues (mapAttrs (n: v: f n v) set));
      in
      ''
        ${conf set (n: v: "set \$${n} ${v}")}
        ${conf bindsym (n: v: "bindsym \$mod+${n} ${v}")}
        ${conf bindsymShift (n: v: "bindsym \$mod+Shift+${n} ${v}")}
        floating_modifier $mod normal
        gaps {
            inner 5
            outer 5
        }
        default_border pixel 2
        bar swaybar_command waybar
        input * xkb_numlock enable
        output * {
          bg ${pkgs.bingimg}/bingimg.jpg fill
          scale 1.5
        }
        exec_always --no-startup-id fcitx5

        # swaymsg -t get_tree
        assign {
          ${conf app_id (n: v: "[app_id = \"${n}\"] ${toString v}")}
          ${conf class (n: v: "[class = \"${n}\"] ${toString v}")}
        }
        for_window [app_id="pavucontrol"] floating enable
        for_window [app_id="org.fcitx."] floating enable

        include /etc/sway/config.d/*
      '';

    "sway/config.d/workspace.conf".text = concatStringsSep "\n" (
      genList (
        x:
        let
          c = x + 1;
          num = toString (c - c / 10 * 10);
          ws = toString c;
        in
        ''
          bindsym $mod+${num} workspace number ${ws}
          bindsym $mod+Shift+${num} move container to workspace number ${ws}
        ''
      ) 10
    );
    "sway/config.d/move.conf".text =
      let
        list = [
          "left"
          "down"
          "up"
          "right"
        ];
        firstUpper = x: lib.toUpper (substring 0 1 x) + substring 1 ((stringLength x) - 1) x;
        resize = concatStringsSep "\n" (
          map (
            x:
            let
              action = x: if x == "left" || x == "up" then "shrink" else "grow";
            in
            ''
              bindsym ''$${x} resize ${action x} width 10px
              bindsym ${firstUpper x} resize ${action x} width 10px
            ''
          ) list
        );
        bindsym = concatStringsSep "\n" (
          map (x: ''
            bindsym $mod+''$${x} focus ${x}
            bindsym $mod+${firstUpper x} focus ${x}
            bindsym $mod+Shift+''$${x} move ${x}
            bindsym $mod+Shift+${firstUpper x} move ${x}
          '') list
        );
      in
      ''
        bindsym $mod+r mode "resize"
        mode "resize" {
        ${resize}
        bindsym Return mode "default"
        bindsym Escape mode "default"
        }
        ${bindsym}
      '';

    "swaylock/config".text = ''
      show-failed-attempts
      daemonize
      image=${pkgs.bingimg}/bingimg-blur.jpg
      scaling=fill
    '';
  };

}
