Neovim is my main editor for software development. This setup builds on [LazyVim](https://github.com/LazyVim/LazyVim) and organizes features into separate Lua files, so each part can be understood, changed, or removed without rebuilding the whole configuration.
## Quick Navigation

- [Why Neovim](#why-neovim)
- [Install the Configuration](#install-the-configuration)
- [First Launch and Updates](#first-launch-and-updates)
- [What the Setup Includes](#what-the-setup-includes)
- [External Tools and Accounts](#external-tools-and-accounts)
- [Troubleshooting](#troubleshooting)

## Why Neovim

I like Neovim because it is fast, keyboard-driven, and highly customizable. Instead of relying on one large editor application to do everything, I add the tools I need for coding, data work, databases, notebooks, Git, Markdown, and AI.

The setup is based on LazyVim, which provides the core configuration and plugin management. My own settings are split into files under `lua/`, while `lazy-lock.json` records plugin versions so the installed setup can be reproduced.

## Install the Configuration

Make sure Neovim and Git are installed. Check that Neovim runs with:

```bash
nvim --version
```

If `~/.config/nvim` already contains a configuration you want to keep, move it aside first. The following command backs it up with a timestamp, then clones the repository into Neovim’s standard configuration directory:

```bash
if [ -d "$HOME/.config/nvim" ]; then
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d-%H%M%S)"
fi

git clone https://github.com/flowdrivenml/neovim-data-dev.git "$HOME/.config/nvim"
```

The directory should now contain `init.lua`, `lazy-lock.json`, `lazyvim.json`, and the `lua/` folder. The key point is that the repository’s contents go directly inside `~/.config/nvim`; you should not end up with an extra nested `neovim-data-dev` directory there.

## First Launch and Updates

Start Neovim:

```bash
nvim
```

On the first launch, LazyVim and Lazy.nvim will initialize the configuration and install its plugins. Let that finish, then run this inside Neovim if you want to synchronize the plugins explicitly:

```vim
:Lazy sync
```

Use `:Mason` to view language servers and developer tools managed through Mason. Use `:checkhealth` to check Neovim’s environment and identify missing dependencies.

To update the configuration later, update the Git checkout and synchronize plugins:

```bash
cd "$HOME/.config/nvim"
git pull
```

Then, inside Neovim:

```vim
:Lazy sync
```

## What the Setup Includes

### Python and Rust

For Python, the configuration includes Pyright, Ruff, and `pylsp` for language-server features such as diagnostics, code navigation, and type information. It also includes formatting tools such as Black and isort.

For Rust, [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) connects Neovim to `rust-analyzer`, and [crates.nvim](https://github.com/saecki/crates.nvim) helps work with dependencies in `Cargo.toml`.
### Databases and SQL

[vim-dadbod](https://github.com/tpope/vim-dadbod), Dadbod UI, and database completion provide a database browser and SQL workflow inside Neovim. The configuration includes support for saving connection details in the Neovim config area. Keep passwords and other secrets private; do not commit real credentials to a public repository.

### AI Tools

[CodeCompanion](https://github.com/olimorris/codecompanion.nvim) is configured to connect to a local Ollama server for chat and code-related actions. Ollama must be installed, running, and serving the model named in the configuration.

The setup also includes an optional [ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim) integration. It reads the `OPENAI_API_KEY` environment variable, so configure that securely in your shell if you use this integration. Do not put the key directly in a Lua file or commit it to GitHub.

[Supermaven](https://github.com/supermaven-inc/supermaven-nvim) provides AI code suggestions while typing and may require its own account or authentication.

### Navigation, Git, and Markdown

[fzf-lua](https://github.com/ibhagwan/fzf-lua) and Telescope help find files, text, buffers, and other project content. [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) displays Git changes beside the code, while [Trouble](https://github.com/folke/trouble.nvim) collects diagnostics in one place.

[render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) improves how Markdown appears inside Neovim. The configuration also includes a project tree, Treesitter highlighting, completion, and snippets.

### Tokyo Night and Appearance

The configuration includes Tokyo Night styling and custom appearance settings, including transparent editor backgrounds. Neovim’s background transparency depends on the terminal as well, so I configure Ghostty’s opacity and blur separately.

## External Tools and Accounts

Neovim plugins provide editor features, but some tools run separately on the system. Language servers, formatters, Python environments, Rust tooling, Ollama, and database servers each have their own installation or configuration steps.

Install only the tools for the workflows you plan to use. For example, Python language support needs the relevant Python tools; Rust support needs a Rust toolchain and `rust-analyzer`; local AI needs Ollama and the configured model. `:Mason` and `:checkhealth` are useful places to see what Neovim can install or what may still be missing.

## Troubleshooting

If Neovim opens with plugin errors, run `:Lazy` and check whether any plugins failed to install. If a language server is missing, open `:Mason` and install or inspect the configured server. If a tool is installed but Neovim cannot find it, check that its executable is available in the shell’s `PATH`.

If the configuration does not start, verify that `init.lua` is at `~/.config/nvim/init.lua` and that the repository was cloned into `~/.config/nvim` rather than a nested subdirectory.