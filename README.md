# Kakoune Configuration: VSCode-Inspired Setup

This configuration customizes Kakoune to mimic Visual Studio Code (VSCode) with a modern UI, familiar keybindings, and optional AI-powered features. It includes a file explorer, status bar, fuzzy file search, and autocompletion, tailored for a terminal-based workflow.

## ✨ Features

* **VSCode-Like Theme:** Dark theme inspired by VSCode’s aesthetic.
* **File Explorer:** Toggleable file tree with `Ctrl+T`.
* **Status Bar:** Powerline-style bar with file and cursor info.
* **Tabs:** Buffer management with `Ctrl+B`.
* **Fuzzy Finder:** File search with `Ctrl+P`.
* **Keybindings:** `Ctrl+S` to save, `Ctrl+Z` to undo, `Ctrl+P` to paste/search, etc.
* **Autocompletion:** LSP support with optional AI via TabNine.

## 🛠️ Prerequisites

* **Kakoune:** Install via `brew install kakoune` (macOS), `sudo apt install kakoune` (Ubuntu), or from [kakoune.org](https://kakoune.org/).
* **Terminal with Nerd Fonts:** For icons (e.g., FiraCode Nerd Font).
* **Git:** For plugin management (`git --version` to check).
* **Node.js:** For LSP/AI (e.g., `brew install node` or `sudo apt install nodejs npm`).
* **xclip:** For clipboard support on Linux (`sudo apt install xclip`).

## 📦 Installation

1.  **Set Up Kakoune Config:**

    * **Locate Config Directory:** Default: `~/.config/kak/`
    * Create it: `mkdir -p ~/.config/kak`
    * Create `kakrc`: Save this into `~/.config/kak/kakrc`:

    ```kak
    # Plugin Manager
    evaluate-commands %sh{
        plugins="$HOME/.config/kak/plugins"
        mkdir -p "$plugins"
        [ -d "$plugins/plug.kak" ] || git clone [https://github.com/robertmeta/plug.kak.git](https://github.com/robertmeta/plug.kak.git) "$plugins/plug.kak"
    }
    source "%val{config}/plugins/plug.kak/rc/plug.kak"

    # Appearance
    plug "kakoune-editor/kakoune-vscode-theme" %{
        colorscheme vscode-dark
    }
    plug "TeddyDD/kakoune-filetree" %{
        map global normal <c-t> ': filetree-toggle<ret>'
    }
    plug "andreyorst/powerline.kak" %{
        powerline-start
    }
    plug "delapouite/kakoune-buffers" %{
        map global normal <c-b> ': enter-buffers-mode<ret>'
    }
    set-option global modelinefmt '%val{bufname} %val{cursor_line}:%val{cursor_char_column} {{context_info}} {{mode_info}} - %val{client}@%val{session}'

    # Keybindings
    map global normal <c-s> ': w<ret>'
    map global normal <c-z> 'u'
    map global normal <c-y> '<a-u>'
    map global normal <c-c> '<a-|>xclip -i -selection clipboard<ret>'
    map global insert <c-c> '<a-|>xclip -i -selection clipboard<ret>'
    map global normal <c-p> '<a-!>xclip -o -selection clipboard<ret>'
    plug "andreyorst/fzf.kak" %{
        map global normal <c-p> ': fzf-mode<ret>'
    }
    map global normal <c-backtick> ': connect terminal<ret>'
    plug "alexherbo/kakoune-lsp" %{
        map global normal <f12> ': lsp-definition<ret>'
        map global normal ',d' ': lsp-definition<ret>'
        lsp-enable
    }
    plug "alexherbo/auto-pairs.kak" %{
        map global normal <c-slash> ': comment-line<ret>'
    }

    # Additional Settings
    set-option global tabstop 4
    set-option global indentwidth 4
    set-option global scrolloff 3,3
    ```

2.  **Install Plugins:**

    * Open Kakoune: Run `kak`.
    * Install Plugins: Type `:plug-install` and press Enter. Wait for completion.
    * Restart: Exit (`:q`) and reopen (`kak`).

3.  **Install AI Features (TabNine via LSP):**

    * Set Up `kakoune-lsp`: Already included in `kakrc` with `lsp-enable`.
    * Install TabNine: Run `npm install -g tabnine` in your terminal.
    * Configure LSP: Create `~/.config/kak-lsp/kak-lsp.toml`:

    ```toml
    [language.python]
    filetypes = ["python"]
    roots = [".git"]
    command = "tabnine"
    args = ["--client=kakoune"]
    ```

    * Test AI: Open a file (`kak main.py`), type code, and see suggestions (use `<tab>` to accept).

## 🧑‍💻 How to Use Kakoune

### Basic Modes

* **Normal Mode:** Default for navigation/selections (press `<esc>` to enter).
* **Insert Mode:** For typing (`i` to enter, `<esc>` to exit).
* **Command Mode:** Run commands with `:` (e.g., `:w` to save).

### Common Controls

* **Navigation:**
    * `h, j, k, l`: Left, down, up, right.
    * `w`: Next word.
    * `b`: Previous word.
    * `gg`: Top of file.
    * `G`: Bottom of file.
    * `<number>G`: Go to line (e.g., `10G`).
* **Editing:**
    * `i`: Insert before selection.
    * `a`: Insert after selection.
    * `o`: New line below.
    * `d`: Delete selection.
    * `y`: Copy selection.
    * `p`: Paste after.
    * `u`: Undo (`Ctrl+Z` also works).
    * `<a-u>`: Redo (`Ctrl+Y` also works).
* **File Management:**
    * `:w`: Save (`Ctrl+S` also works).
    * `:q`: Quit.
    * `:wq`: Save and quit.

### Custom Keybindings

* `Ctrl+S`: Save.
* `Ctrl+Z`: Undo.
* `Ctrl+Y`: Redo.
* `Ctrl+C`: Copy (Normal/Insert mode).
* `Ctrl+P`: Paste or file search.
* `Ctrl+T`: Toggle file explorer.
* ``Ctrl+` ``: Open terminal.
* `F12` or `,d`: Go to definition.
* `Ctrl+/`: Comment line.
* `Ctrl+B`: Buffer management.

### AI Usage

* **TabNine:** Type code; suggestions appear via LSP. Press `<tab>` to accept.

### Exiting Kakoune

* `:q`: Quit if no changes.
* `:q!`: Force quit.

### Troubleshooting

* **Plugins Fail:** Run `:plug-clean` then `:plug-install`.
* **No AI:** Check `kak-lsp.toml` and run `:lsp-enable`.
* **No Icons:** Set a Nerd Font in your terminal.

### Customization

* **Theme:** Change `vscode-dark` to another (e.g., `vscode-light`).
* **LSP:** Add more languages in `kak-lsp.toml` (e.g., `[language.javascript]`).
