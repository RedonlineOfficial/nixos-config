{ ... }: {
  flake.modules.nixos.core-base = { lib, ... }: {
    # --- Boot ---------------------------------------------------------------------------
    boot.loader = {
      systemd-boot.enable = lib.mkDefault true;
      efi.canTouchEfiVariables = lib.mkDefault true;
    };

    # --- Nix ----------------------------------------------------------------------------
    nix = {
      settings = {
        # Enable flakes
        experimental-features = [
          "flakes"
          "nix-command"
        ];

        # Optimization
        # Gets triggered on every build, mainly autoUpgrade
        auto-optimise-store = true;
      };

      # Garbage Collection
      # Runs from autoUpgrade (role/workstation.nix) and uses gc.options
      gc.options = "--delete-older-than 14d";
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
