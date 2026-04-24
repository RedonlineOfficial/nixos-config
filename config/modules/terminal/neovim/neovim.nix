{ self, inputs, ... }: {
  flake-file.inputs = {
    nvf.url = "github:notashelf/nvf";
  };

  flake.homeModules.neovim = {...}: {
    imports = [
      inputs.nvf.homeManagerModules.default

      self.homeModules.neovimOptions
      self.homeModules.neovimLsp
    ];

    programs.nvf = {
      enable = true;

      settings = {
        vim = {
          vimAlias = true;
          theme.transparent = true;
        
        };
      };
    };
  };
}
