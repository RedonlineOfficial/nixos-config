{ inputs, ... }: {
  flake-file.inputs = {
    nvf.url = "github:notashelf/nvf";
  };

  flake.homeModules.neovim = {...}: {
    imports = [inputs.nvf.homeManagerModules.default];

    programs.nvf {
      enable = true;
    };
  };
}
