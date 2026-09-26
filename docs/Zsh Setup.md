Zsh is the interactive shell I use in Ghostty. Its personal startup file, `~/.zshrc`, configures the prompt, loads plugins and tools, and defines shell functions.

Zsh configuration is shell code, not JSON. I keep reusable settings in the development-setup repository and source them from my personal `~/.zshrc`. The example below keeps Tokyo Night syntax colors and `repoclip`, while leaving out the other custom functions and machine-specific connection settings.

## Quick Navigation

- [How the Files Are Organized](#how-the-files-are-organized)
- [Tokyo Night Styling File](#tokyo-night-styling-file)
- [Personal Zsh Configuration](#personal-zsh-configuration)
- [What Repoclip Does](#what-repoclip-does)
- [Keep Personal Values Private](#keep-personal-values-private)

## How the Files Are Organized

Keep the reusable Zsh files separate from the Neovim configuration. For example:

```text
linux-dev-setup/
└── configs/
    └── zsh/
        └── tokyo-night.zsh
```

The main `~/.zshrc` stays in your home directory. It loads the reusable Tokyo Night styling file and contains personal shell setup.

## Tokyo Night Styling File

Save this Zsh code as `configs/zsh/tokyo-night.zsh`:

```zsh
# Tokyo Night styles for zsh-syntax-highlighting

typeset -gA ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[command]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7dcfff'
ZSH_HIGHLIGHT_STYLES[function]='fg=#bb9af7'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#2ac3de'
ZSH_HIGHLIGHT_STYLES[path]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#ff9e64'
```

## Personal Zsh Configuration

Add the relevant setup to `~/.zshrc`. Change the path to `tokyo-night.zsh` if you checked out the setup repository somewhere other than `~/projects/linux-dev-setup`.

```zsh
# Powerlevel10k instant prompt. Keep near the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Load custom syntax colors before Oh My Zsh loads its plugins.
TOKYO_NIGHT_ZSH="$HOME/projects/linux-dev-setup/configs/zsh/tokyo-night.zsh"
[[ -r "$TOKYO_NIGHT_ZSH" ]] && source "$TOKYO_NIGHT_ZSH"
unset TOKYO_NIGHT_ZSH

plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  sudo
  docker
  python
  rust
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

# Keep PATH entries unique and add common user command directories.
typeset -U path
path=("$HOME/.local/bin" "/snap/bin" $path)

# Initialize the first Conda installation found.
# Miniforge is preferred here; remove or reorder candidates if needed.
for conda_root in "$HOME/miniforge3" "$HOME/miniconda3"; do
  if [[ -r "$conda_root/etc/profile.d/conda.sh" ]]; then
    source "$conda_root/etc/profile.d/conda.sh"
    break
  fi
done
unset conda_root

# Initialize NVM if it is installed.
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# Remove an existing alias so the function below is used.
unalias repoclip 2>/dev/null

repoclip() {
  local use_gitignore=true
  local targets=()

  for arg in "$@"; do
    case "$arg" in
      --no-gitignore)
        use_gitignore=false
        ;;
      -h|--help)
        echo "Usage:"
        echo "  repoclip                         # Current repo, respects .gitignore"
        echo "  repoclip src tests               # Only specified paths"
        echo "  repoclip --no-gitignore          # Current repo, ignore .gitignore"
        echo "  repoclip --no-gitignore src      # Specific paths, ignore .gitignore"
        return 0
        ;;
      *)
        targets+=("$arg")
        ;;
    esac
  done

  if (( ${#targets[@]} == 0 )); then
    targets=(".")
  fi

  local repomix_cmd=("npx" "repomix@latest")

  if [[ "$use_gitignore" == false ]]; then
    repomix_cmd+=("--no-gitignore")
  fi

  repomix_cmd+=("${targets[@]}")

  echo "[1/2] Token count tree..."
  "${repomix_cmd[@]}" --token-count-tree || return 1

  echo
  echo "[2/2] Copying repository snapshot to clipboard..."

  if command -v wl-copy >/dev/null 2>&1; then
    "${repomix_cmd[@]}" --style plain --stdout | wl-copy
  elif command -v xclip >/dev/null 2>&1; then
    "${repomix_cmd[@]}" --style plain --stdout | xclip -selection clipboard
  else
    echo "Error: No clipboard tool found."
    echo "Install wl-clipboard (Wayland) or xclip (X11)."
    return 1
  fi

  echo "Done."
}
```

This is a cleaned example based on my setup. It omits machine-specific Windows paths, duplicate PATH and NVM entries, service connection values, and API-key variables. It also leaves out my other custom functions; `repoclip` is the only custom function included.

## What Repoclip Does

`repoclip` runs [Repomix](https://github.com/yamadashy/repomix) on the current repository or on the files and directories passed as arguments. It first displays a token-count tree, then copies a plain-text repository snapshot to the clipboard.

By default, Repomix respects `.gitignore`. Use `--no-gitignore` only when you intentionally want ignored files included. Review what you are copying before sharing it with an AI tool; ignored files can contain private data if you explicitly include them.

The function requires `npx` and a clipboard utility. On Kubuntu with Wayland, `wl-copy` is provided by `wl-clipboard`. Check that the commands are available with:

```bash
command -v npx
command -v wl-copy
```

Examples:

```bash
repoclip
repoclip src
repoclip src tests
repoclip src Cargo.toml README.md
repoclip --no-gitignore
```

## Keep Personal Values Private

My full `~/.zshrc` contains personal paths and environment settings for local tools and services. Keep real passwords, API keys, and private connection strings out of public repositories and shareable configuration examples. Put personal values in private local configuration and show placeholders in documentation.

After changing `~/.zshrc`, start a fresh shell to reload it:

```bash
exec zsh
```