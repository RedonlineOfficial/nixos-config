{ ... }: {
  flake.modules.nixos.core-laptop = { lib, ... }: {
    # --- Lid Switch ---------------------------------------------------------------------
    # core/mixins/hibernate.nix will override HandlePowerKey and HandleLidSwitch to
    # "hibernate"
    services.logind.settings.login = {
      HandlePowerKey = lib.mkDefault "suspend";
      HandlePowerKeyLongPress = "poweroff";
      HandleLidSwitch = lib.mkDefault "suspend";
      HandleLidSwitchDocked = "ignore";
    };

    # --- Power Management ---------------------------------------------------------------
    services.system76-scheduler = {
      enable = true;
      settings.cfsProfiles.enable = true; # Better cpu cycle scheduling
    };
    services.thermald.enable = lib.mkDefault true; # Intel temperature control daemon
    services.power-profiles-daemon.enable = false; # Disable GNOME power management

    # Enables TLP
    services.tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    # --- Input --------------------------------------------------------------------------
    services.libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        clickMethod = "clickfinger"; # 1 finger = left, 2 = right, 3 = middle
        scrollMethod = "edge"; # Scroll with finger on edge of touchpad
      };
    };

  };
}
