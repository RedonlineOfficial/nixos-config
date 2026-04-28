{self, ...}: {
  flake.nixosModules.profiles-desktopHyprland = {
    imports = [
      self.nixosModules.desktop-hyprland
    ];
  };

  flake.homeModules.profiles-desktopHyprland = {
    imports = [
      self.homeModules.desktop-hyprland
      self.homeModules.hyprpaper
      self.homeModules.kitty
    ];
  };
}
