{
  self,
  inputs,
  ...
}: {
  flake.homeModules.desktop-hyprlandKeybinds = {...}: {
    wayland.windowManager.hyprland.settings = {
      "$mainMod" = "SUPER";

      "$terminal" = "kitty";

      bind = [
        # MODS, key, dispatcher, params

        # Move focus in a direction
        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, r"

        # Move focus to specific workspace
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move focused window in a direction
        "mainMod SHIFT, h, movewindow, l"
        "mainMod SHIFT, j, movewindow, d"
        "mainMod SHIFT, k, movewindow, u"
        "mainMod SHIFT, l, movewindow, r"

        # Move focused window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Hyprland
        "$mainMod, q, killactive,"
        "$mainMod SHIFT, q, exit"
        "$mainMod SHIFT, r, exec, hyprctl reload"

        # Master Layout
        "$mainMod, p, addmaster"
        "$mainMod SHIFT, p, removemaster"

        # Window states
        "$mainMod SHIFT, f, fullscreen, 0 toggle"
        "$mainMod, v, togglefloating"

        # Special Workspaces
        "$mainMod, s, togglespecialworkspace, scratchpad"
        "$mainMod SHIFT, s, movetoworkspace, special:scratchpad"
        "$mainMod, a, togglespecialworkspace, authentication"
        "$mainMod SHIFT, a, movetoworkspace, special:authentication"
        "$mainMod, m, togglespecialworkspace, music"
        "$mainMod SHIFT, m, movetoworkspace, special:music"

        # Apps
        "$mainMod, Return, exec, $terminal"
        "$mainMod, b, exec, $browser"
        "$mainMod, Space, exec, $launcher"
        "$mainMod, F, exec, $fileExplorer"

        # Submaps
        "$mainMod SHIFT, R, submap, resize_window"
      ];

      submaps = {
        resize_window = {
          settings.binde = [
            ", h, resizeactive, -10 0"
            ", j, resizeactive, 0 10"
            ", k, resizeactive, 0 -10"
            ", l, resizeactive, 10 0"

            ", esc, submap, reset"
          ];
        };
      };
    };
  };
}
