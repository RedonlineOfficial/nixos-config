{ config, lib, ... }: let
  inherit (config) myNixos;
in {
  config = lib.mkIf myNixos.isLaptop {
    powerManagement.enable = true;

    services = {
      libinput.enable = true;
      fprintd.enable = true;
      thermald.enable = true;
      tlp = {
	enable = true;
	settings = {
	  START_CHARGE_THRESH_BAT0 = 65; # 40 and below it starts to charge
	  STOP_CHARGE_THRESH_BAT0 = 90; # 80 and above it stops charging
	};
      };
    };
  };
}
