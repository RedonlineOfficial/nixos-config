{ inputs, lib, ... }: {
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  #   IMPORTS
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  imports = [ inputs.flake-file.flakeModules.default ];

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  #   FLAKE CONFIG
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  flake-file = {
    # ── Inputs ─────────────────────────────────────────────────────────────
    inputs = {
      # Nixpkgs
      nixpkgs.url = lib.mkDefault "github:NixOS/nixpkgs/nixos-unstable";

      # Dendritic Framework
      flake-parts.url = "github:hercules-ci/flake-parts";
      flake-file.url = "github:vic/flake-file";
      import-tree.url = "github:vic/import-tree";
    };

    # ── Outputs ────────────────────────────────────────────────────────────
    outputs = "inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)";
  };

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  #   COMMON HOST MODULE
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  flake.nixosModules.hostCommon = { pkgs, ... }: {
    # ── Imports ────────────────────────────────────────────────────────────
    imports = [
      self.nixosModules.home-manager
    ];

    # ── Boot Config ────────────────────────────────────────────────────────
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # ── Networking ─────────────────────────────────────────────────────────

    networking.networkmanager.enable = true;

    # ── Time & Locale ──────────────────────────────────────────────────────
    time.timeZone = "America/Phoenix";
    i18n.defaultLocale = "en_US.UTF-8";

    # ── System Packages ────────────────────────────────────────────────────
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      neovim
    ];

    # ── Services ───────────────────────────────────────────────────────────
    services.openssh.enable = true;

    # ── System Config ──────────────────────────────────────────────────────
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nix.gc = {
      automatic = true;
      dates = "Saturday *-*-* 23:00:00";
      persistent = true;
    };

    nix.optimise = {
      automatic = true;
      dates = "Saturday *-*-* 23:00:00";
      persistent = true;
    };
  };

}
