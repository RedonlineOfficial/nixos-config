{
  wayland.windowManager.hyprland = {
    settings = {
      # modifiers, key, dispatcher, params

      "$mod" = "Super";

      "$terminal" = "alacritty";
      "$browser" = "firefox";
      "$menu" = "wofi --show drun";

      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, f, exec, $browser"
        "$mod, Space, exec, $menu"

        "$mod, q, killactive,"
        "$mod, t, togglefloating, activewindow"

        "$mod, s, togglespecialworkspace, scratchpad"
        "$mod_shift, s, movetoworkspace, special:scratchpad"

        "$mod_shift, Escape, exit,"

        "$mod, h, movefocus, l" 
        "$mod, j, movefocus, d" 
        "$mod, k, movefocus, u" 
        "$mod, l, movefocus, r" 

        "$mod_shift, h, movewindow, l"
        "$mod_shift, j, movewindow, d"
        "$mod_shift, k, movewindow, u"
        "$mod_shift, l, movewindow, r"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod_shift, 1, movetoworkspace, 1"
        "$mod_shift, 2, movetoworkspace, 2"
        "$mod_shift, 3, movetoworkspace, 3"
        "$mod_shift, 4, movetoworkspace, 4"
        "$mod_shift, 5, movetoworkspace, 5"
        "$mod_shift, 6, movetoworkspace, 6"
        "$mod_shift, 7, movetoworkspace, 7"
        "$mod_shift, 8, movetoworkspace, 8"
        "$mod_shift, 9, movetoworkspace, 9"
        "$mod_shift, 0, movetoworkspace, 10"
      ];
    };

    extraConfig = ''
      # window resize
      bind = $mod, r, submap, resize
      
      submap = resize
      binde = , h, resizeactive, -10 0
      binde = , j, resizeactive, 0 10
      binde = , k, resizeactive, 0 -10
      binde = , l, resizeactive, 10 0
      bind = , escape, submap, reset
      bind = $mod, r, submap, reset
      submap = reset
    '';
  };
}
