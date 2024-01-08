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
  };

  environment.etc = {
    "sway/config".text = ''
      set $mod Mod4
      set $term foot
      set $left h
      set $down j
      set $up k
      set $right l
      set $menu wofi -S run -s ${./dotfiles/wofi/style.css} | xargs swaymsg exec --
      set $screenshot ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" $HOME/Pictures/$(date +\"%F_%T\").png
      set $lock swaylock -C /etc/swaylock/config
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
      include /etc/sway/config.d/*
    '';

    "sway/config.d/window.conf".text = ''
      assign {
        # swaymsg -t get_tree
        [app_id="foot"] 1
        [class="Microsoft-edge"] 2
        [class="Chromium-browser"] 2
        [app_id="chromium-browser"] 2
        [app_id="pcmanfm"] 3
        [class="Pcmanfm"] 3
        [app_id="xarchiver"] 3
        [app_id="code-url-handler"] 4
        [class="Code"] 4
        [class="Logseq"] 4
        [app_id="lapce"] 4
        [app_id="mpv"] 5
        [app_id="org.telegram.desktop"] 5
        [app_id="sqlitebrowser"] 5
      }
      for_window [app_id="pavucontrol"] floating enable
      for_window [app_id="org.fcitx."] floating enable
    '';
    "sway/config.d/bindsym.conf".text = ''
      bindsym $mod+Return exec $term
      bindsym $mod+Shift+q kill
      floating_modifier $mod normal
      bindsym $mod+Shift+c reload
      bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'
      bindsym $mod+b splith
      bindsym $mod+v splitv
      bindsym $mod+s layout stacking
      bindsym $mod+w layout tabbed
      bindsym $mod+e layout toggle split
      bindsym $mod+f fullscreen
      bindsym $mod+Shift+space floating toggle
      bindsym $mod+space focus mode_toggle
      bindsym $mod+a focus parent
      bindsym $mod+Shift+minus move scratchpad
      bindsym $mod+minus scratchpad show
      bindsym $mod+Scroll_Lock exec $lock
      bindsym $mod+Print exec $screenshot
      bindsym $mod+d exec $menu
    '';
    "sway/config.d/workspace.conf".text = concatStringsSep "\n" (genList
      (x:
        let
          c = x + 1;
          num = toString (c - c / 10 * 10);
          ws = toString c;
        in
        ''
          bindsym $mod+${num} workspace number ${ws}
          bindsym $mod+Shift+${num} move container to workspace number ${ws}
        ''
      ) 10);
    "sway/config.d/move.conf".text =
      let
        list = [ "left" "down" "up" "right" ];
        firstUpper = x: lib.toUpper (substring 0 1 x) + substring 1 ((stringLength x) - 1) x;
      in
      ''
        bindsym $mod+r mode "resize"
        mode "resize" {
      '' + concatStringsSep "\n"
        (map
          (x:
            let
              action = x: if x == "left" || x == "up" then "shrink" else "grow";
            in
            ''
              bindsym ''$${x} resize ${action x} width 10px
              bindsym ${firstUpper x} resize ${action x} width 10px
            ''
          )
          list) + ''
        bindsym Return mode "default"
        bindsym Escape mode "default"
        }
      '' + concatStringsSep "\n"
        (map
          (x:
            ''
              bindsym $mod+''$${x} focus ${x}
              bindsym $mod+${firstUpper x} focus ${x}
              bindsym $mod+Shift+''$${x} move ${x}
              bindsym $mod+Shift+${firstUpper x} move ${x}
            ''
          )
          list);

    "swaylock/config".text = ''
      show-failed-attempts
      daemonize
      image=${pkgs.bingimg}/bingimg-blur.jpg
      scaling=fill
    '';
  };

}

