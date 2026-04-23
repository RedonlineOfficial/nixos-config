{ self, inputs, ... }: {
  flake.nixosModules.git = {
    programs.git.enable = true;
  };

  flake.homeModules.git = { lib, ... }: {
    programs.git = {
      enable = true;
      userName = lib.mkDefault "RedonlineOfficial";
      userEmail = lib.mkDefault "dev@redonline.me";
      config = {
        init.defaultBranch = "main";
        core.editor = "nvim -f";
        pull.rebase = false;
        commit.template = ./gitcommit;
      };
    };
  };
}


