{
  self,
  inputs,
  ...
}: {
  flake.homeModules.nixosKeymaps = {...}: {
    programs.nvf.settings.vim = {
      globals.mapleader = " ";

      maps.normal = {
        # General
        "<Space>" = {action = "<Nop>";};
        "<ESC>" = {
          action = "<cmd>nohlsearch<CR>";
          desc = "Clear search highlights";
        };

        # Move between splits
        "<C-h>" = {
          action = "<C-w>h";
          desc = "Move to left split";
        };
        "<C-j>" = {
          action = "<C-w>j";
          desc = "Move to split below";
        };
        "<C-k>" = {
          action = "<C-w>k";
          desc = "Move to split above";
        };
        "<C-l>" = {
          action = "<C-w>l";
          desc = "Move to right split";
        };

        # Resize splits
        "<C-Up>" = {
          action = ":resize -2<CR>";
          silent = true;
          desc = "Shrink split height";
        };
        "<C-Down>" = {
          action = ":resize +2<CR>";
          silent = true;
          desc = "Grow split height";
        };
        "<C-Left>" = {
          action = ":vertical resize -2<CR>";
          silent = true;
          desc = "Shrink split width";
        };
        "<C-Right>" = {
          action = ":vertical resize +2<CR>";
          silent = true;
          desc = "Grow split width";
        };

        # Save/Exit
        "<leader>w" = {
          action = "<cmd>w<CR>";
          desc = "Save";
        };
        "<leader>x" = {
          action = "<cmd>x<CR>";
          desc = "Save and quit";
        };
        "<leader>q" = {
          action = "<cmd>q<CR>";
          desc = "Quit";
        };
        "<leader>Q" = {
          action = "<cmd>q!<CR>";
          desc = "Force quit";
        };
      };
    };

    maps.visual = {
      # Move selected text up/down
      "J" = {
        action = ":m '>+1<CR>gv=gv";
        silent = true;
        desc = "Move selection down";
      };
      "K" = {
        action = ":m '<-2<CR>gv=gv";
        silent = true;
        desc = "Move selection up";
      };
    };
  };
}
