{
  self,
  nixos,
  ...
}: {
  flake.homeModules.desktop-hyprlandLayouts = {...}: {
    wayland.windowManager.hyprland.settings = {
      general.layout = "master";

      master = {
        allow_small_split = true;
        mfact = 0.60;
      };

      dwindle = {
        force_split = 2;
      };
    };
  };
}
