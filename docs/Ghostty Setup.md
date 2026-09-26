Ghostty is my favorite terminal. I like its speed and customization, and the transparent background lets my animated wallpaper show through. The blur makes that movement feel atmospheric without making the terminal text hard to read.

## Quick Navigation

- [Download Ghostty on Kubuntu](#download-ghostty-on-kubuntu)
- [Where the Configuration Lives](#where-the-configuration-lives)
- [Customize the Terminal](#customize-the-terminal)
- [Useful Ghostty Links](#useful-ghostty-links)

## Download Ghostty on Kubuntu

Ghostty is available in the official Ubuntu package repository for Ubuntu 26.04 and newer. On Kubuntu, install it from a terminal with: :chatgpt-content-reference{index="0"}

```bash
sudo apt update
sudo apt install ghostty
```

Check that it installed:

```bash
ghostty --version
```

For other Linux versions or installation options, check the [official Ghostty installation guide](https://ghostty.org/docs/install/binary)

## Where the Configuration Lives

Ghostty reads a text-based configuration file from the XDG configuration directory. On Kubuntu, the usual location is:

```text
~/.config/ghostty/config.ghostty
```

Ghostty versions before 1.2.3 used the filename `config`. Current versions still recognize it, but `config.ghostty` is the current name. :chatgpt-content-reference{index="1"}

I keep the reusable Ghostty configuration in the setup repository, separate from the Neovim configuration. It contains my Tokyo Night colors, JetBrains Mono font, window appearance, transparency and blur, mouse behavior, clipboard selection, and keybindings.

To open the live configuration in Neovim:

```bash
nvim ~/.config/ghostty/config.ghostty
```

Ghostty reloads its configuration on Linux with **Ctrl+Shift+,**. :chatgpt-content-reference{index="2"}

## Customize the Terminal

Ghostty uses a simple text format with settings written as `key = value`. I adjust its appearance and behavior in the config file, then reload it to try the changes. For example, the opacity and blur settings let the animated wallpaper show through while keeping the terminal comfortable to read.

Ghostty includes built-in themes. To browse them interactively, run:

```bash
ghostty +list-themes
```

To inspect the default configuration and documented settings:

```bash
ghostty +show-config --default --docs
```

The [configuration reference](https://ghostty.org/docs/config/reference) documents available settings, and the [themes guide](https://ghostty.org/docs/features/theme) explains how Ghostty finds theme files. :chatgpt-content-reference{index="3"}

## Useful Ghostty Links

- [Ghostty downloads](https://ghostty.org/download)
- [Official installation guide](https://ghostty.org/docs/install/binary)
- [Official configuration guide](https://ghostty.org/docs/config)
- [Configuration reference](https://ghostty.org/docs/config/reference)
- [Themes guide](https://ghostty.org/docs/features/theme)
- [Official Ghostty GitHub repository](https://github.com/ghostty-org/ghostty)