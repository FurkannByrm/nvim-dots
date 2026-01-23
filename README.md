# Neovim C++ & Robotics Configuration

A comprehensive Neovim setup optimized for C++ development and ROS2 robotics workflows.

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

### Window Management

| Key/Command | Action |
|-------------|--------|
| `:vsplit` | Split window vertically |
| `:split` | Split window horizontally |
| `Ctrl + h` | Navigate to left window |
| `Ctrl + l` | Navigate to right window |
| `Ctrl + j` | Navigate to window below |
| `Ctrl + k` | Navigate to window above |

### Code Editing

| Key | Action |
|-----|--------|
| `Alt + j` | Move line/selection down |
| `Alt + k` | Move line/selection up |
| `gcc` | Toggle comment (single line) |
| `gc` | Toggle comment (visual selection) |
| `i` | Enter Insert mode at cursor |
| `a` | Enter Insert mode after cursor |
| `A` | Jump to end of line and enter Insert mode |
| `o` | Open new line below and enter Insert mode |
| `O` | Open new line above and enter Insert mode |
| `u` | Undo |
| `Ctrl + r` | Redo |

### LSP & Code Intelligence

| Key | Action |
|-----|--------|
| `<leader>d` (Space + d) | Show diagnostic message popup |
| `]d` | Jump to next diagnostic |
| `[d` | Jump to previous diagnostic |
| `<leader>xx` (Space + xx) | Open Trouble: project-wide diagnostics |
| `gd` | Go to Definition |
| `K` | Show documentation (hover info) |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<leader>b` (Space + b) | Toggle breakpoint |
| `F5` | Start/Continue debugging |
| `F10` | Step Over |
| `F11` | Step Into |

### Terminal

| Key/Command | Action |
|-------------|--------|
| `Ctrl + \` | Toggle floating terminal |
| `:!<command>` | Execute shell command (e.g., `:!make`) |

##  Notes

- Leader key is set to `Space`
- All keybindings are case-sensitive
- Use `:checkhealth` to verify plugin installations
