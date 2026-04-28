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

        wallpaper = [
          {
            monitor = "";
            path = "./nix-dark-binary-8k.png";
            fit_mode = "cover";
          }
        ];
      };
    };
  };
}
