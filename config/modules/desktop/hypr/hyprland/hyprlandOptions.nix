{
  self,
  inputs,
  ...
}: {
  flake.homeModules.desktop-hyprlandOptions.nix = {...}: {
    wayland.windowManager.hyprland.settings = {
      general = {
        border_size = 1;
        gaps_out = 7;
        resize_on_border = true;
      };

      decoration = {
        rounding = 10;
        blur = {
          size = 3;
        };
      };

      input = {
        numlock_by_default = true;
        touchpad = {
          disable_while_typing = true;
          tap-to-click = true;
        };
      };

      gestures = {
        workspace_swipe_touch = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        animate_manual_resizes = true;
        on_focus_under_fullscreen = 0;
      };
    };
  };
}
