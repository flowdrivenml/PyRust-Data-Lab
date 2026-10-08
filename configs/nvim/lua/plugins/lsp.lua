return {
  {
    "mrcjkb/rustaceanvim",
    enabled = false,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},

        ruff = {
          on_attach = function(client, _)
            client.server_capabilities.hoverProvider = false
          end,
        },

        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = true },
                mccabe = { enabled = true },
                mypy = { enabled = true },
                ruff = { enabled = false },
              },
            },
          },
        },

        -- Rust Analyzer
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                allTargets = true,
              },
              check = {
                allTargets = true,
              },
            },
          },
        },
      },
    },
  },
}
