{ ... }: {
  flake.modules.nixos.core-workstation = { config, pkgs, ... }: {
    # --- Networking ---------------------------------------------------------------------
    networking.networkmanager.enable = true;

    # --- Time ---------------------------------------------------------------------------
    time.timeZone = "America/Phoenix";

    # --- Auto Upgrade -------------------------------------------------------------------
    # A github action automatically upgrades and checks the lockfile every Saturday at
    # midnight, then commits and pushes the change to the github repository.  Auto upgrade
    # then upgrades each system from that repository 3 hours after.
    system.autoUpgrade = {
      enable = true;
      allowReboot = false;
      dates = "Sat 03:00";
      flake = "github:RedonlineOfficial/nixos-config#${config.networking.hostName}";
      persistent = true;
      runGarbageCollection = true;
    };

    # --- Graphics -----------------------------------------------------------------------
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # --- Audio --------------------------------------------------------------------------
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # --- Printing -----------------------------------------------------------------------
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.printing.enable = true;
    services.ipp-usb.enable = true;

    # --- Fonts --------------------------------------------------------------------------
    fonts = {
      packages = with pkgs; [
        noto-fonts
        liberation_ttf
        corefonts
        nerd-fonts.fira-code
      ];

      fontconfig = {
        defaultFonts = {
          serif = [ "Noto Serif" ];
          sansSerif = [ "Noto Sans" ];
          monospace = [ "Fira Code Nerd Font" ];
        };
      };
    };

    # --- Packages -----------------------------------------------------------------------
    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];
  };
}
