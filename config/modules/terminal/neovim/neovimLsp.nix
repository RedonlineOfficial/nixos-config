{ self, inputs, ... }: {
  flake.nixosModules.neovimLsp = {...}: {
    programs.vim = {
      lsp.enable = true;

      languages = {
        nix = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
          format.enable = true;
          format.type = [ "alejandra" ];
        };

        bash = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };
      };

      formatter.conform-nvim = {
        enable = true;
        setupOpts.format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
      };
    };
  };
}
