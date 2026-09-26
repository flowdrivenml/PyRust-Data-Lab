return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- LazyVim will automatically install these via Mason and set them up
      servers = {
        pyright = {},
        ruff = {
          -- Customizing the ruff on_attach behavior
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
      },
    },
  },
}
