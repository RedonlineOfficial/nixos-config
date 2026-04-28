{
  self,
  inputs,
  ...
}: {
  flake.homeModules.hyprpaper = {
    services.hyprpaper = {
      enable = true;

      settings = {
        splash = false;

        preload = [
          "~/nixos-config/config/modules/desktop/hypr/hyprpaper/nix-dark-binary-8k.png"
        ];
        wallpaper = [
          {
            monitor = "";
            path = "~/nixos-config/config/modules/desktop/hypr/hyprpaper/nix-dark-binary-8k.png";
            fit_mode = "cover";
          }
        ];
      };
    };
  };
}
