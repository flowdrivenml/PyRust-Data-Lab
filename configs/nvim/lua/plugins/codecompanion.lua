return {
  {
    "olimorris/codecompanion.nvim",
    version = "^18.0.0",
    event = "VeryLazy",
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion chat",    mode = "n" },
      { "<leader>aa", "<cmd>CodeCompanion<cr>",     desc = "CodeCompanion actions", mode = { "n", "v" } },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "http://127.0.0.1:11434",
              },
              schema = {
                model = {
                  default = "gemma4:26b",
                },
                num_ctx = {
                  default = 8192,
                },
                temperature = {
                  default = 0,
                },
              },
            })
          end,
        },

        strategies = {
          chat = { adapter = "ollama" },
          inline = { adapter = "ollama" },
          cmd = { adapter = "ollama" },
        },

        opts = {
          log_level = "ERROR",
        },
      })
    end,
  },
}
