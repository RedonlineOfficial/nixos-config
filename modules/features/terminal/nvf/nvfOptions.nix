{ self, inputs, ... }: {
  flake.homeModules.nvfOptions = { ... }: {
    # ===========================================================================
    # NVF OPTIONS
    # ===========================================================================
    programs.nvf.settings = {
      vim.options = {
        # --- General -----------------------------------------------------------
        selection = "inclusive";
        mouse = "a";
        clipboard = "unnamedplus";
        modifiable = true;
        encoding = "utf-8";
        wrap = false;
        autoread = true;
        autowrite = false;
        hidden = true;
        errorbells = false;
        backspace = "indent,eol,start";
        autochdir = false;

        # --- Appearance --------------------------------------------------------
        number = true;
        relativenumber = true;
        cursorline = true;
        cursorlineopt = "screenline";
        signcolumn = "yes";
        colorcolumn = "80";
        showmatch = true;
        showmode = false;
        conceallevel = 0;
        concealcursor = "";
        synmaxcol = 300;
        fillchars = "eob: ";
        termguicolors = true;

        # --- Tabbing --------------------------------------------------------
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        expandtab = true;

        # --- Indentation --------------------------------------------------------
        smartindent = true;
        autoindent = true;

        # --- Search --------------------------------------------------------
        ignorecase = true;
        smartcase = true;
        hlsearch = true;
        incsearch = true;

        # --- Scroll --------------------------------------------------------
        scrolloff = 10;
        sidescrolloff = 10;

        # --- Windows --------------------------------------------------------
        wildmenu = true;
        wildmode = "longest:full,full";
        pumheight = 10;
        pumblend = 10;
        winblend = 0;
        cmdheight = 1;

        # --- Backup & Undo --------------------------------------------------------
        backup = false; 
        writebackup = false;
        swapfile = false;
        undofile = true;

        # --- Splits --------------------------------------------------------
        splitbelow = true;
        splitright = true;

        # --- Completions --------------------------------------------------------
        completeopt = "menuone,noinsert,noselect";
        inccommand = "split";

        # --- Performance --------------------------------------------------------
        redrawtime = 10000;
        maxmempattern = 20000;
        updatetime = 300;
        timeoutlen = 500;
        ttimeoutlen = 0;
      };

      vim.luaConfigRC.options = # lua
      ''
        -- Append to existing options
        vim.opt.iskeyword:append("-")
        vim.opt.path:append("**")
        vim.opt.diffopt:append("linematch:60")

        -- Undo Directory
        local undodir = vim.fn.expand("~/.local/share/nvim/undodir")
        if vim.fn.isdirectory(undodir) == 0 then
          vim.fn.mkdir(undodir, "p")
        end
        vim.opt.undodir = undodir
      '';

      vim.luaConfigRC.markdown-wrap = # lua
      ''
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "markdown",
          callback = function()
            vim.opt_local.textwidth = 80
            vim.opt_local.formatoptions:append("t")  -- auto-wrap while typing
            vim.opt_local.formatoptions:append("w")  -- trailing whitespace = paragraph continues
          end,
        })
      '';
    };
  };
}
