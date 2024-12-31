{ pkgs, ... }:
with builtins;

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "nixos";
      };
      default_session = initial_session;
    };
  };

  programs.hyprland = {
    enable = true;
    # xwayland.enable = false;
  };

  environment.etc = {
    "xdg/hypr/hyprland.conf".text =
      ''
        $mod = SUPER
        monitor=,preferred,auto,1.5
        exec-once = waybar & fcitx5
        exec-once = ${pkgs.swaybg}/bin/swaybg -i ${pkgs.bingimg}/share/bingimg.jpg -m fill
        env = XCURSOR_SIZE,48
        input {
            numlock_by_default = true
        }
        general {
            gaps_in = 5
            gaps_out = 20
            border_size = 2
            col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
            col.inactive_border = rgba(595959aa)
            layout = dwindle
        }
        decoration {
        }
        animations {
            enabled = true
            bezier = myBezier, 0.05, 0.9, 0.1, 1.05
            animation = windows, 1, 7, myBezier
            animation = windowsOut, 1, 7, default, popin 80%
            animation = border, 1, 10, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 7, default
            animation = workspaces, 1, 6, default
        }
        dwindle {
            pseudotile = true
            preserve_split = true
        }
        master {
        }
        gestures {
            workspace_swipe = false
        }
        windowrulev2 = workspace 1,class:^(foot)$,title:^(foot)$
        windowrulev2 = workspace 2,class:^(chromium-browser)$
        windowrulev2 = workspace 3,class:^(pcmanfm)$
        windowrulev2 = workspace 4,class:^(codium)$
        windowrulev2 = workspace 4,class:^(dev\.zed\.Zed)$
        windowrulev2 = workspace 4,class:^(obsidian)$
        windowrulev2 = workspace 5,class:^(mpv)$
        windowrulev2 = workspace 5,class:^(org\.telegram\.desktop)$

        windowrulev2 = float,class:^(org\.fcitx\.)$,title:^(Fcitx Configuration)$
        windowrulev2 = float,title:^(Open File)$
        windowrulev2 = float,title:^(Open Folder)$
        windowrulev2 = float,title:^(Add Folder to Workspace)$
        windowrulev2 = opacity 0.75 0.5,floating:1
        windowrulev2 = opacity 1 1,class:^(fcitx)$
        windowrulev2 = opacity 0.75 0.5,class:^(foot)$
        windowrulev2 = opacity 0.85 0.5,class:^(codium)$
        windowrulev2 = opacity 0.85 0.5,class:^(dev\.zed\.Zed)$

        bind = $mod, Return, exec, foot
        bind = $mod SHIFT, Q, killactive,
        bind = $mod SHIFT, E, exit,
        bind = $mod, Space, togglefloating,
        bind = $mod, P, pseudo, # dwindle
        bind = $mod, J, togglesplit, # dwindle
        bind = $mod, left, movefocus, l
        bind = $mod, right, movefocus, r
        bind = $mod, up, movefocus, u
        bind = $mod, down, movefocus, d
        bind = $mod, mouse_down, workspace, e+1
        bind = $mod, mouse_up, workspace, e-1
        bindm = $mod, mouse:272, movewindow
        bindm = $mod, mouse:273, resizewindow
        bind = $mod, D, exec, ${pkgs.fuzzel}/bin/fuzzel
        bind = $mod, Print, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" $HOME/Pictures/$(date +"%F_%T").png
      ''
      + concatStringsSep "\n" (
        genList (
          x:
          let
            c = x + 1;
            num = toString (c - c / 10 * 10);
            ws = toString c;
          in
          ''
            bind = $mod, ${num}, workspace, ${ws}
            bind = $mod SHIFT, ${num}, movetoworkspace, ${ws}
          ''
        ) 10
      );
  };

}
