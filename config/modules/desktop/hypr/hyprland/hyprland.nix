{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.desktop-hyprland = {...}: {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };

  flake.homeModules.desktop-hyprland = {...}: {
    imports = [
      self.homeModules.desktop-hyprlandOptions
      self.homeModules.desktop-hyprlandKeybinds
      self.homeModules.desktop-hyprlandMonitors
      self.homeModules.desktop-hyprlandLayouts
      self.homeModules.desktop-hyprlandWindows
      self.homeModules.desktop-hyprlandWorkspaces
    ];
    wayland.windowManager.hyprland = {
      enable = true;
    };
  };
}
