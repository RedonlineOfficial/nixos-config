{ self, inputs, ... }: {
  flake.nixosModules.ssh = { ... }: {
    services.openssh = {
      enable = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    programs.ssh = {
      startAgent = true;
    };
    environment.sessionVariables = {
      SSH_AUTH_SOCK = "/run/user/$UID/ssh-agent";
    };
  };
}
