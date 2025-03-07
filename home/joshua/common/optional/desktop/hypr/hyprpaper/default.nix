{ pkgs, ... }: let
  wallpaper = pkgs.fetchurl {
    url = "https://i.redd.it/lwvmbjrgbfke1.png";
    hash = "sha256-2Sm4e35x9yT2n/5nrRSUpTd8LVU3344cOO06owaREIQ=";
  };
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [(builtins.toString wallpaper)];
      wallpaper = ",${builtins.toString wallpaper}";

      #ipc = "off";
      splash = false;
    };
  };
}
