## Quick Navigation

- [Why I Use Repoclip](#why-i-use-repoclip)
- [What You Need](#what-you-need)
- [Install the Dependencies](#install-the-dependencies)
- [Add the Repoclip Function to Zsh](#add-the-repoclip-function-to-zsh)
- [Use Repoclip](#use-repoclip)
- [Check What You Share](#check-what-you-share)
- [How It Works](#how-it-works)

## Why I Use Repoclip

I do not use AI to generate an entire application blindly. I often ask it to suggest ideas, explain parts of a codebase, or help write documentation. For useful answers, it needs enough context about the project.

Repoclip gives me a quick way to collect selected project files into one AI-friendly text snapshot, then copy that snapshot to the clipboard. I can review it and paste it into a chatbot when I want help with a specific project.

Repoclip is my Zsh function; it uses [Repomix](https://github.com/yamadashy/repomix) to build the project snapshot. Repomix can also show a token-count tree, which helps estimate how large the context will be. :chatgpt-content-reference{index="0"}

## What You Need

Repoclip needs:

- Zsh, because the function is written for Zsh.
- Node.js and npm, which provide `npx`. The function runs Repomix through `npx`, so you do not need to install Repomix globally.
- A clipboard command: `wl-copy` for Wayland, or `xclip` as a fallback.

Check whether Node.js and npm are already available:

```bash
node --version
npm --version
npx --version
```

My `~/.zshrc` already loads NVM. If Node.js is missing, install it using the [NVM installation instructions](https://github.com/nvm-sh/nvm#installing-and-updating), then open a new terminal and repeat the checks.

## Install the Dependencies

On Kubuntu, install the Wayland clipboard utility with:

```bash
sudo apt update
sudo apt install wl-clipboard
```

Ubuntu packages `wl-clipboard` as the command-line Wayland clipboard utility. :chatgpt-content-reference{index="1"}

If you use an X11 session or want the fallback clipboard utility as well, install `xclip`:

```bash
sudo apt install xclip
```

## Add the Repoclip Function to Zsh

Open your Zsh startup file:

```bash
nvim ~/.zshrc
```

Paste the function below at the end of the file and save it:

```zsh
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
        echo "  repoclip --no-gitignore          # Current repo, ignores .gitignore"
        echo "  repoclip --no-gitignore src      # Specific paths, ignores .gitignore"
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

Reload Zsh so it reads the new function:

```bash
exec zsh
```

## Use Repoclip

Run Repoclip from the project directory you want to share:

```bash
cd ~/projects/my-project
repoclip
```

With no paths, it processes the current directory and respects `.gitignore`. You can pass paths to include only selected parts of the project:

```bash
repoclip src
repoclip src tests
repoclip src Cargo.toml README.md
```

The `--help` option prints the usage summary:

```bash
repoclip --help
```

## Check What You Share

Repoclip copies project content to your clipboard; it does not decide which information is appropriate to share with a chatbot. Review the selected files and the generated token-count tree before pasting the snapshot.

By default, Repomix respects `.gitignore`, but a sensitive file will still be included if it is not ignored. Add private files such as `.env` files to `.gitignore`, and check the clipboard content before sharing it.

Use `--no-gitignore` only when you deliberately want ignored files included:

```bash
repoclip --no-gitignore src
```

## How It Works

The function runs Repomix twice. First, it prints the token-count tree so I can see the selected project content and approximate context size. Then it creates a plain-text snapshot and sends it to the clipboard with `wl-copy` or `xclip`. Repomix supports both the token-count tree and standard-output modes used by this function. :chatgpt-content-reference{index="2"}

After it prints **Done.**, paste the clipboard contents into the chatbot and ask a focused question about the project.