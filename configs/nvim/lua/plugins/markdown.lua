return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    -- Leaving opts empty forces the plugin to use clean, standard defaults
    opts = {
      file_types = { "markdown", "jupynvim", "ipynb", "python" },
      render_modes = { "n", "c", "t", "v" },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- Tells Neovim to smoothly hide raw formatting characters globally
      vim.opt.conceallevel = 2
      vim.opt.concealcursor = "nc"
    end,
  },
}
