-- ============================================================================
-- Keymaps (centralized)
-- ============================================================================
local map = vim.keymap.set
local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- ============================================================================
-- Code / LSP / Tools  (<leader>c is reserved for "code" in many configs)
-- ============================================================================

-- Trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts("Trouble: Toggle"))

-- Telescope (only if you actually use Telescope over fzf-lua)
do
  local ok, builtin = pcall(require, "telescope.builtin")
  if ok then
    map("n", "<leader>ff", builtin.find_files, opts("Find Files (Telescope)"))
    map("n", "<leader>fg", builtin.live_grep, opts("Live Grep (Telescope)"))
    map("n", "<leader>fb", builtin.buffers, opts("Buffers (Telescope)"))
    map("n", "<leader>fh", builtin.help_tags, opts("Help (Telescope)"))
  end
end

-- Rust-only helpers (buffer-local)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function(ev)
    map("n", "<leader>ra", vim.lsp.buf.code_action, { buffer = ev.buf, silent = true, desc = "Rust: Code Action" })
    map("n", "<leader>rh", vim.lsp.buf.hover, { buffer = ev.buf, silent = true, desc = "Rust: Hover" })
  end,
})

-- ============================================================================
-- OpenAI / ChatGPT.nvim (cloud)  (<leader>o = OpenAI)
-- ============================================================================

map("n", "<leader>oc", "<cmd>ChatGPT<cr>", opts("OpenAI: ChatGPT"))
map("v", "<leader>oe", "<cmd>ChatGPTEditWithInstruction<cr>", opts("OpenAI: Edit selection"))

map("n", "<leader>om", function()
  _G.OpenAISetModel("four_o_mini")
end, opts("OpenAI: gpt-4o-mini"))
map("n", "<leader>or", function()
  _G.OpenAISetModel("o3_mini")
end, opts("OpenAI: o3-mini"))

-- ============================================================================
-- Jupyter / nvim-ipy  (<leader>j = Jupyter)
-- ============================================================================
-- Recommend: buffer-local only for python to avoid global conflicts.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(ev)
    map("n", "<leader>jc", "<cmd>IPythonSendCell<cr>", { buffer = ev.buf, silent = true, desc = "Jupyter: Send cell" })
    map(
      "v",
      "<leader>js",
      "<cmd>IPythonSendVisualSelection<cr>",
      { buffer = ev.buf, silent = true, desc = "Jupyter: Send selection" }
    )
    map("n", "<leader>jf", "<cmd>IPythonSendFile<cr>", { buffer = ev.buf, silent = true, desc = "Jupyter: Send file" })
  end,
})
