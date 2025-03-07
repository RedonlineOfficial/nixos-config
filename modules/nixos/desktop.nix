{ config, lib, ... }: let
  inherit (config) myNixos;
in {
  config = lib.mkIf myNixos.isDesktop {

    hardware = {
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
      pulseaudio.enable = false;
    };

    services = {
      pipewire = {
        enable = true;
        jack.enable = true;
        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
      };
    };

    security.rtkit.enable = true;

    environment.systemPackages = with pkgs; [
      libreoffice-qt
      alacritty
      pavucontrol
    ];
  };
}
