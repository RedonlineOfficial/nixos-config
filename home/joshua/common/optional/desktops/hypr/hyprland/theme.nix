
_: let
  nordBorderInactive = "4c566a";
  nordBorderActive = "81a1c1";

in {

  wayland.windowManager.hyprland.settings = {
    general = {
      # Borders
      border_size = 2;
      no_border_on_floating = false;
      "col.active_border" = "rgb(${nordBorderActive})";
      "col.inactive_border" = "rgb(${nordBorderInactive})";

      # Gaps
      gaps_in = 2;
      gaps_out = 5;
    };

    decoration = {
      rounding = 15;
      rounding_power = 2;
      blur.enabled = false;
    };

    animations = {
      enabled = true;
      first_launch_animation = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      font_family = "Ubuntu Nerd Font";
      animate_manual_resizes = true;
      animate_mouse_windowdragging = true;
    };
  };
}
