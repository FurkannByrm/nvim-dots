# Neovim Configuration

##  Installation

### Prerequisites

```bash
sudo apt update && sudo apt install -y \
    neovim \
    git \
    curl \
    build-essential \
    gdb \
    clangd \
    python3-pip
```

sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install neovim git curl build-essential clangd gdb python3-pip -y


sudo apt purge nodejs npm -y

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

sudo apt install -y nodejs

node -v

sudo apt-install xclip// for copy


### Setup

```bash
# Backup existing config if it exists
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Clone this repository
git clone https://github.com/YOUR_USERNAME/REPO_NAME ~/.config/nvim

# Launch Neovim
nvim
```

## LSP Configuration

### CMake Projects

```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
ln -s build/compile_commands.json .
```

### ROS2 Projects

```bash
colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -s build/YOUR_PACKAGE_NAME/compile_commands.json .
```

## FOR AI Cursor and CheckBox

:Copilot auth

##  Keybindings Reference

### File Management (Neo-tree)

| Key | Action |
|-----|--------|
| `<leader>e` (Space + e) | Toggle file explorer sidebar |
| `a` | Add new file/folder (add `/` for directories) |
| `d` | Delete file or directory |
| `r` | Rename file or directory |
| `x` | Cut (for moving files) |
| `c` | Copy file |
| `p` | Paste (complete move or copy) |
| `y` | Copy file path to clipboard |
| `H` | Toggle hidden files (.git, .clangd, etc.) |
| `s` | Open selected file in horizontal split |
| `v` | Open selected file in vertical split |
| `t` | Open file in a new tab |

### Window Management

| Key/Command | Action |
|-------------|--------|
| `:vsplit` or `:vsp` | Split window vertically |
| `:split` or `:sp` | Split window horizontally |
| `:vsp file.cpp` | Split vertically and open the specified file |
| `:sp file.hpp` | Split horizontally and open the specified file |
| `Ctrl + w + h/j/k/l` | Navigate between windows (left/down/up/right) |
| `Ctrl + w + r` | Rotate window positions |
| `Ctrl + w + H` | Move current window to the far left |
| `Ctrl + w + J` | Move current window to the bottom |
| `Ctrl + w + K` | Move current window to the top |
| `Ctrl + w + L` | Move current window to the far right |

#### Practical Scenario: Opening Files Side by Side

Let's say `Point.cpp` is open and you want `Point.hpp` next to it:

1. Type `:vsp` (the screen splits with an empty pane).
2. Press `Ctrl + w + l` to switch to the right pane.
3. Type `:e Point.hpp` or find the file from Neo-tree.

### C++ Header/Source Switching (a.vim)

| Key/Command | Action |
|-------------|--------|
| `ga` | Toggle between header and source in current window (.cpp ↔ .hpp) |
| `:AV` | Open the alternate file in a vertical split |
| `:AS` | Open the alternate file in a horizontal split |

### Code Editing

| Key | Action |
|-----|--------|
| `Alt + j` | Move line/selection down |
| `Alt + k` | Move line/selection up |
| `i` | Enter Insert mode at cursor |
| `a` | Enter Insert mode after cursor |
| `A` | Jump to end of line and enter Insert mode |
| `o` | Open new line below and enter Insert mode |
| `O` | Open new line above and enter Insert mode |
| `u` | Undo |
| `Ctrl + r` | Redo |

### Commenting (Comment.nvim)

| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment (`//`) on current line |
| `gc` | Toggle comment on selected lines (Visual mode) |
| `gbc` | Toggle block comment (`/* ... */`) on current line |
| `3gcc` | Comment 3 lines starting from cursor |

### Surround (nvim-surround)

| Key | Action |
|-----|--------|
| `ysw"` | Surround word with quotes (`"`) |
| `ds"` | Delete surrounding quotes |

### Multi-Cursor (vim-visual-multi)

| Key | Action |
|-----|--------|
| `Ctrl + n` | Multi-select same word in file, press `c` to edit all at once |
| `q` | Skip a match while selecting (Skip) |

### LSP & Code Intelligence

| Key | Action |
|-----|--------|
| `gl` | Show detailed error: opens diagnostic description in a floating window |
| `<leader>d` (Space + d) | Show diagnostic message popup |
| `]d` | Jump to next diagnostic |
| `[d` | Jump to previous diagnostic |
| `<leader>xx` (Space + xx) | Trouble: list all project-wide diagnostics |
| `gd` | Go to Definition |
| `K` | Show documentation (hover info) |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<leader>b` (Space + b) | Toggle breakpoint |
| `F5` | Start / Continue debugging |
| `F10` | Step Over |
| `F11` | Step Into |

### Terminal

| Key/Command | Action |
|-------------|--------|
| `Ctrl + \` | Toggle floating terminal |
| `:!<command>` | Execute shell command (e.g., `:!make`) |

### System Clipboard

To copy text from Neovim and paste it into another terminal or browser, you need to use the system clipboard. Vim's internal register (`y`) does not communicate with the outside world by default.

| Key | Action |
|-----|--------|
| `"+y` | Copy selected text to system clipboard |
| `"+p` | Paste from system clipboard |

**Usage:**

1. Select the text you want to copy using Visual Mode (`v` or `V`).
2. Press `"` then `+` then `y`.
3. Switch to another terminal and paste with `Ctrl + Shift + v`.

> **Note:** System clipboard support requires `xclip`: `sudo apt install xclip`

## Notes

- Leader key is set to `Space`
- All keybindings are case-sensitive
- Use `:checkhealth` to verify plugin installations
