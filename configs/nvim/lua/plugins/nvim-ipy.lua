return {
  "bfredl/nvim-ipy",
  lazy = false,
  config = function()
    -- Disable plugin default mappings; we define our own in lua/config/keymaps.lua
    vim.g.nvim_ipy_perform_mappings = 0
  end,
}
