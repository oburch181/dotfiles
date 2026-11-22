# Noob Guide to Your Dotfiles

Welcome! This environment is built using Nix Home Manager. Here is a quick reference guide for the main tools and hotkeys configured in this setup.

## Tmux (Terminal Multiplexer)
Tmux allows you to have multiple windows and panes in a single terminal session. The default prefix key is **`Ctrl + b`**. You must press the prefix before using most tmux commands.

*   `Ctrl + b` then `c` : Create a new window
*   `Ctrl + b` then `n` : Go to the next window
*   `Ctrl + b` then `p` : Go to the previous window
*   `Ctrl + b` then `&` : Close current window
*   `Ctrl + b` then `%` : Split pane vertically (left/right)
*   `Ctrl + b` then `"` : Split pane horizontally (top/bottom)
*   `Ctrl + b` then `Arrow Keys` : Move between panes
*   `Ctrl + b` then `d` : Detach from the session (leaves it running in the background)
*   `tmux attach` (in shell) : Reattach to a background session
*   *Note: Mouse support is enabled, so you can click to switch panes or drag to resize them.*

## Helix (Default Text Editor)
Helix is a modal text editor (similar to Vim/Neovim) with multiple-cursor support built-in.

*   `i` : Enter Insert mode (to type text)
*   `Esc` : Return to Normal mode
*   `v` : Enter Select mode (to highlight text)
*   `:` : Enter Command mode (at the bottom)
    *   `:w` : Save (write)
    *   `:q` : Quit
    *   `:wq` : Save and quit
*   `u` : Undo
*   `U` : Redo
*   `y` : Yank (copy selected text)
*   `p` : Paste
*   `d` : Delete selected text

## Micro (Simple Text Editor)
If you prefer standard keyboard shortcuts over a modal editor, `micro` is also installed.

*   `Ctrl + s` : Save
*   `Ctrl + q` : Quit
*   `Ctrl + c` : Copy
*   `Ctrl + x` : Cut
*   `Ctrl + v` : Paste
*   `Ctrl + z` : Undo
*   `Ctrl + f` : Find

## Fzf (Fuzzy Finder)
Fzf is integrated into your Bash and Zsh shells for quick searching.

*   `Ctrl + r` : Search your command history fuzzy-style
*   `Ctrl + t` : Fuzzy search for files in the current directory tree and paste the path into your command line
*   `Alt + c` : Fuzzy search for directories and `cd` into the selected one

## Other Tools
*   **WezTerm**: Your configured terminal emulator. It's set up with the "Tokyo Night" theme, JetBrainsMono Nerd Font, and hides the tab bar if you only have one tab open.
*   **Starship**: A fast and highly customizable prompt for your shell. It works out of the box with Zsh and Bash.
*   **Git**: Default branch is set to `main` and it will rebase by default when pulling. *(Don't forget to update your name and email in `home.nix`!)*
