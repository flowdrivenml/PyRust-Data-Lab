return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      -- Pricing per 1M tokens (OpenAI official)
      -- gpt-4o-mini: $0.15 in / $0.60 out
      -- o3-mini:     $1.10 in / $4.40 out
      -- Source: https://platform.openai.com/pricing
      local models = {
        four_o_mini = { name = "gpt-4o-mini", input_cost = 0.15, output_cost = 0.60 },
        o3_mini     = { name = "o3-mini", input_cost = 1.10, output_cost = 4.40 },
      }

      -- Default model
      vim.g.openai_current_model = models.four_o_mini

      local function calculate_cost(prompt_tokens, completion_tokens)
        local model = vim.g.openai_current_model
        local input_cost = (prompt_tokens / 1000000) * model.input_cost
        local output_cost = (completion_tokens / 1000000) * model.output_cost
        local total_cost = input_cost + output_cost
        vim.notify(string.format(
          "OpenAI cost: $%.6f (%s | %d in, %d out)",
          total_cost,
          model.name,
          prompt_tokens,
          completion_tokens
        ))
      end

      local function apply_setup()
        require("chatgpt").setup({
          api_key_cmd = "echo $OPENAI_API_KEY",
          openai_params = {
            model = vim.g.openai_current_model.name,
          },
          popup_input = {
            prompt = "🔍 Enter your request: ",
            submit = "<C-Enter>",
          },
          popup_window = {
            border = "rounded",
            width = 80,
            height = 20,
          },
          edit_with_instructions = {
            diff = false,
            keymaps = {
              accept = "<C-y>",
              dismiss = "<C-c>",
            },
          },
          on_response = function(response)
            -- ChatGPT.nvim response shape can vary; be defensive
            local usage = response and response.usage
            if usage and usage.prompt_tokens and usage.completion_tokens then
              calculate_cost(usage.prompt_tokens, usage.completion_tokens)
            end
          end,
        })
      end

      -- Expose a global function so keymaps can switch model cleanly from keymaps.lua
      _G.OpenAISetModel = function(key)
        local m = models[key]
        if not m then
          vim.notify("Unknown model key: " .. tostring(key), vim.log.levels.ERROR)
          return
        end
        vim.g.openai_current_model = m
        apply_setup()
        vim.notify("Switched OpenAI model to: " .. m.name)
      end

      -- Initial setup
      apply_setup()
    end,
  },
}
