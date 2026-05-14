{ self, inputs, ... }: {
  flake.homeModules.nvfLsp = { ... }: {
    programs.nvf.settings.vim = {
      lsp.enable = true;

      formatter.conform-nvim = {
        enable = true;
        setupOpts.format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
      };

      languages = {
        bash = { 
          enable = true; 
          lsp.enable = true; 
          treesitter.enable = true; 
        };

        nix = {
          enable = true;
          lsp.enable = true;
          lsp.servers = [ "nixd" ];
          treesitter.enable = true;
          format.enable = true;
          format.type = [];
        };
      };
    };
  };
}
