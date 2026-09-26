return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = { cpp = true }, -- Add any filetypes you want it disabled in
      color = {
        suggestion_color = "#ffffff",
        cterm = 244,
      },
      disable_inline_completion = false, -- Keep this false to use it like Codeium
    })
  end,
}
