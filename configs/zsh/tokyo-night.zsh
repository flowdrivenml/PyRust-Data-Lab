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
