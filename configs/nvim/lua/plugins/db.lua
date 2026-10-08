return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- Added "sql" here for database syntax highlighting
      vim.list_extend(opts.ensure_installed, { "python", "lua", "rust", "toml", "json", "sql" })
      opts.highlight = opts.highlight or {}
      opts.highlight.enable = true
      opts.indent = opts.indent or {}
      opts.indent.enable = true
      opts.auto_install = true
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          cmd = { "rustup", "run", "stable", "rust-analyzer" },
          settings = {
            ["rust-analyzer"] = {
              inlayHints = { enable = false },
            },
          },
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({})
    end,
  },

  -- DATABASE ENGINE & UI PACKAGES
  -- DATABASE ENGINE & UI
  {
    "tpope/vim-dadbod",
    lazy = true,
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },

    init = function()
      -- DBUI settings must be available before the plugin loads.
      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"
      vim.g.db_ui_show_database_navigation = 1
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_winwidth = 38

      -- Toggle the database panel with <leader>db.
      vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<CR>", {
        desc = "Toggle database UI",
      })

      -- Apply these accents after Tokyo Night (or another colorscheme) loads.
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local highlights = {
            DBUIRoot = { fg = "#7aa2f7", bold = true },
            DBUIFolder = { fg = "#bb9af7", bold = true },
            DBUIFolderName = { fg = "#c0caf5" },
            DBUITable = { fg = "#7dcfff" },
            DBUIQuery = { fg = "#9ece6a" },
            DBUIConnection = { fg = "#e0af68", bold = true },
          }

          for group, settings in pairs(highlights) do
            vim.api.nvim_set_hl(0, group, settings)
          end
        end,
      })

      -- Also apply the accents if the colorscheme loaded before this spec.
      vim.schedule(function()
        vim.api.nvim_exec_autocmds("ColorScheme", { pattern = "*" })
      end)

      -- Add Dadbod completion to SQL-family buffers when nvim-cmp is available.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          local cmp_ok, cmp = pcall(require, "cmp")
          if cmp_ok then
            cmp.setup.buffer({
              sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
              },
            })
          end
        end,
      })
    end,

    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          -- Added vim-dadbod-completion source to global list safely
          { name = "vim-dadbod-completion" },
        },
      })

      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = function()
      require("fidget").setup({})
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({})
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })

      vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "DiffAdd" })
      vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffChange" })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "DiffDelete" })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
}
