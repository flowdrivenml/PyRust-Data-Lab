return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Disable auto popup (you must trigger manually)
      opts.completion = opts.completion or {}
      opts.completion.autocomplete = false

      -- Ensure snippet expand is set (LazyVim already does, but keep explicit)
      opts.snippet = opts.snippet or {}
      opts.snippet.expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end

      -- Merge/override keymaps (keep LazyVim's preset insert, modify what you want)
      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      })

      -- Sources: keep existing + ensure these are present
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      })

      return opts
    end,
  },
}
