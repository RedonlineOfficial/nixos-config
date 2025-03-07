{
  imports = [
    ./theme.nix
    ./monitors.nix
    ./bindings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      general = {
      	layout = "dwindle";
      	no_focus_fallback = false;
      	resize_on_border = false;
      	extend_border_grab_area = 15;
      	hover_icon_on_border = true;
      	allow_tearing = false;
      	resize_corner = 0;

      	ecosystem = {
      	  no_update_news = true;
      	  no_donation_nag = true;
	};
      };
    };

    extraConfig = ''
      exec-once = waybar
    '';
  };
}
