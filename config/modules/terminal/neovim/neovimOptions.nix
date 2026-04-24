{ inputs, ... }: {
  flake.homeModules.neovimOptions = { ... }: {
    programs.nvf.vim = {
      options = {
        # ── General ──────────────────────────────────────────────────────
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

        # ── Appearance ───────────────────────────────────────────────────
        number = true;
        relativenumber = true;
        cursorline = true;
        signcolumn = "yes";
        colorcolumn = "100";
        showmatch = true;
        showmode = false;
        conceallevel = 0;
        concealcursor = "";
        synmaxcol = 300;
        fillchars = "eob: ";
        termguicolors = true;

        # ── Tabbing ──────────────────────────────────────────────────────
        tabstop = 2;
        shiftwidth = 2;
        softtabstop = 2;
        expandtab = true;

        # ── Indentation ──────────────────────────────────────────────────
        smartindent = true;
        autoindent = true;


        # ── Search ───────────────────────────────────────────────────────
        ignorecase = true;
        smartcase = true;
        hlsearch = true;
        incsearch = true;

        # ── Scroll ───────────────────────────────────────────────────────
        scrolloff = 10;
        sidescrolloff = 10;

        # ── Windows ──────────────────────────────────────────────────────
        wildmenu = true;
        wildmode = "longest:full,full";
        pumheight = 10;
        pumblend = 10;
        winblend = 0;
        cmdheight = 1;

        # ── Backup & Undo ────────────────────────────────────────────────
        backup = false;
        writebackup = false;
        swapfile = false;
        undofile = true;

        # ── Splits ───────────────────────────────────────────────────────
        splitbelow = true;
        splitright = true;

        # ── Completions ──────────────────────────────────────────────────
        completeopt = "menuone,noinsert,noselect";
        inccommand = "split";

        # ── Performance ──────────────────────────────────────────────────
        redrawtime = 10000;
        maxmempattern = 20000;
        updatetime = 300;
        timeoutlen = 500;
        ttimeoutlen = 0;
      };

      luaConfigRC.options = ''
        -- Append to existing options
        vim.opt.iskeyword:append("-")
        vim.opt.path:append("**")
        vim.opt.diffopt:append("linematch:60")

        -- Undo directory
        local undodir = vim.fn.expand("~/.local/share/nvim/undodir")
        if vim.fn.isdirectory(undodir) == 0 then
          vim.fn.mkdir(undodir, "p")
        end
        vim.opt.undodir = undodir

        vim.api.nvim_create_user_command("Format", function()
          require("conform").format({ async = true })
        end, {})
      '';
    };
  };
}
