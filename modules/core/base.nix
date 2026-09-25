{ ... }: {
  flake.modules.nixos.core-base = { lib, ... }: {
    # --- Boot ---------------------------------------------------------------------------
    boot.loader = {
      systemd-boot.enable = lib.mkDefault true;
      efi.canTouchEfiVariables = lib.mkDefault true;
    };

    # --- Nix ----------------------------------------------------------------------------
    nix = {
      settings.experimental-features = [
        "flakes"
        "nix-command"
      ];

      gc = {
        automatic = true;
        dates = "Sun 00:00:00";
        persistent = true;
        options = "--delete-older-than 14d";
      };

      optimise = {
        automatic = true;
        dates = "Sun 01:00:00";
        persistent = true;
      };
    };

    # --- Nixpkgs ------------------------------------------------------------------------
    nixpkgs.config.allowUnfree = true;

    # --- Locale -------------------------------------------------------------------------
    i18n.defaultLocale = "en_US.UTF-8";

    console = {
      font = lib.mkDefault "Lat2-Terminus16";
      useXkbConfig = true;
    };

    services.xserver.xkb = {
      layout = "us";
      options = "caps:escape_shifted_capslock";
    };
  };
}
