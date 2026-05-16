{ self, inputs, ... }: {
  flake.homeModules.nvfKeybinds = { ... }: {
    programs.nvf.settings.vim = {
      globals.mapleader = " ";

      maps.normal = {
        "<Space>" = { action = "<Nop>"; };
        "<ESC>" = { action = "<cmd>nohlsearch<CR>"; desc = "Clear search highlights"; };

        "<C-h>" = { action = "<C-w>h"; desc = "Move to left split"; };
        "<C-j>" = { action = "<C-w>j"; desc = "Move to split below"; };
        "<C-k>" = { action = "<C-w>k"; desc = "Move to split above"; };
        "<C-l>" = { action = "<C-w>l"; desc = "Move to right split"; };

        "<C-Left>" = { action = ":resize -2 <CR>"; silent = true; desc = "Shrink split width"; }; 
        "<C-Down>" = { action = ":vertical resize +2 <CR>"; silent = true; desc = "Grow split height"; }; 
        "<C-Up>" = { action = ":vertial resize -2 <CR>"; silent = true; desc = "Shrink split height"; }; 
        "<C-Right>" = { action = ":resize +2 <CR>"; silent = true; desc = "Grow split width"; }; 

        "<leader>w" = { action = "<cmd>w<CR>"; desc = "Save"; };
        "<leader>x" = { action = "<cmd>x<CR>"; desc = "Save & Exit"; };
        "<leader>q" = { action = "<cmd>q<CR>"; desc = "Quit"; };
        "<leader>Q" = { action = "<cmd>q!<CR>"; desc = "Force quit"; };
      };

      maps.visual = {
        "J" = { action = ":m '>+1<CR>gv=gv"; silent = true; desc = "Move selection down"; };
        "K" = { action = ":m '<-2<CR>gv=gv"; silent = true; desc = "Move selection up"; };
      };
    };
  };
}
