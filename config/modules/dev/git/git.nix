{ self, inputs, ... }: {
  flake.nixosModules.git = { ... }: {
    programs.git.enable = true;
  };

  flake.homeModules.git = { lib, ... }: {
    programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        core.editor = "nvim -f";
        user.name = lib.mkDefault "RedonlineOfficial";
        user.email = lib.mkDefault "dev@redonline.me";
        pull.rebase = false;
        commit.template = "${./gitcommit}";
      };
    };
  };
}


