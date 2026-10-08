# My Neovim Setup

I am a big fan of **Neovim**, so this repository contains the setup I use for coding, data work, databases, Markdown, and AI-assisted development.

It is based on **[LazyVim](https://github.com/LazyVim/LazyVim)** and **[lazy.nvim](https://github.com/folke/lazy.nvim)**. I keep most features in separate Lua files, so it is easy to understand, replace, or remove individual parts.

![Neovim](https://img.shields.io/badge/Neovim-0.10+-57A143?logo=neovim&logoColor=white)
![Python](https://img.shields.io/badge/Python-Development-3776AB?logo=python&logoColor=white)
![Rust](https://img.shields.io/badge/Rust-Development-000000?logo=rust&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Database_Work-336791)
![AI](https://img.shields.io/badge/AI-Local_%26_Cloud-8A2BE2)

## Quick Navigation

- [What is included?](#what-is-included)
- [Why this setup?](#why-this-setup)

## What is included?

* **Python development** — [Pyright](https://github.com/microsoft/pyright), Ruff, pylsp, Black, and isort give me diagnostics, formatting, linting, type information, and code navigation directly inside Neovim.

* **Rust development** — [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) runs `rust-analyzer`, while [crates.nvim](https://github.com/saecki/crates.nvim) makes working with Cargo dependencies more convenient.

* **Jupyter / IPython workflow** — [nvim-ipy](https://github.com/bfredl/nvim-ipy) lets me send a Python cell, selected code, or an entire file to IPython. This is useful for exploratory data analysis without leaving Neovim.

* **Database UI inside Neovim** — [vim-dadbod](https://github.com/tpope/vim-dadbod), Dadbod UI, and database-aware SQL completion let me connect to databases, browse them, write queries, and get autocomplete without opening another application.

* **Local AI with Ollama** — [CodeCompanion](https://github.com/olimorris/codecompanion.nvim) is connected to a local Ollama server. I can use local models for chat, commands, and code changes directly from the editor.

* **OpenAI inside Neovim** — I also keep optional OpenAI integration for cases where I want to use a cloud model instead of a local one. It can open chat or edit selected code directly from Neovim.

* **AI autocomplete** — [Supermaven](https://github.com/supermaven-inc/supermaven-nvim) provides inline code suggestions while typing.

* **Fast navigation** — [fzf-lua](https://github.com/ibhagwan/fzf-lua) and Telescope make it easy to search files, text, buffers, and documentation without navigating directories manually.

* **Treesitter** — better syntax highlighting and indentation for the languages I use, including Python, Rust, Lua, JSON, TOML, and SQL.

* **Git integration** — [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) shows added, changed, and deleted lines directly next to the code.

* **Diagnostics** — [Trouble](https://github.com/folke/trouble.nvim) gives me one place to see errors, warnings, and other diagnostics across the project.

* **Markdown rendering** — [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) renders Markdown formatting directly inside Neovim, which makes README files and notes much easier to read.

* **File tree** — [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) gives me a simple project explorer when I want a more traditional view of the repository.

* **Completion and snippets** — `nvim-cmp` combines LSP suggestions, snippets, filesystem paths, and current-buffer words into one completion system. I keep automatic popup disabled and trigger completion when I actually want it.

* **Custom appearance** — transparent windows, custom syntax colors, Tokyonight, and a few UI changes make the editor feel less like a default setup and more like something adapted to my workflow.

* **WSL clipboard support** — when running Neovim through WSL, the configuration uses `win32yank` so copying between Linux, Neovim, and Windows works normally.

## Why this setup?

I do not try to make Neovim reproduce every feature of a large IDE.

The idea is to keep the editor **fast and keyboard-driven**, while adding the tools I actually use: Python and Rust development, SQL databases, Jupyter-style experimentation, Git, Markdown, search, and AI.

It is mostly a personal configuration, but if you use a similar workflow you may find some useful ideas here or reuse individual parts in your own setup.
