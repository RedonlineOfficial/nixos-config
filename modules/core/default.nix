{ self, ... }: {
  # Aggregator only: imports modules shared by all hosts.
  # Do not declare or define options here; put them in their own module.
  flake.modules.nixos.core = { ... }: {
    imports = with self.modules.nixos; [
      # Add core modules here
    ];
  };
}
