# Neovim Configuration for C++ & ROS 2 Development

A modern, fast, and practical Neovim setup focused on:

- **C++20/23**
- **ROS 2**
- **Python**
- **Lua**

Built around `lazy.nvim`, `nvim-cmp`, `mason.nvim`, `nvim-treesitter`, and `nvim-dap`.

---

## Table of Contents

- [Features](#features)
- [Quick Install (Single Copy-Paste Block)](#quick-install-single-copy-paste-block)
- [Step-by-Step Installation](#step-by-step-installation)
- [First Launch](#first-launch)
- [Project Setup for C++ and ROS 2](#project-setup-for-c-and-ros-2)
- [Keybindings](#keybindings)
- [Health Check](#health-check)
- [Troubleshooting](#troubleshooting)
- [Repository](#repository)

---

## Features

- Fast plugin management with `lazy.nvim`
- LSP support and completion via `nvim-cmp`
- Syntax highlighting and parsing via `nvim-treesitter`
- Tool/LSP installer via `mason.nvim`
- Debug workflow with `nvim-dap`
- File navigation with Neo-tree
- C++/ROS 2 workflow with `clangd`

---

## Quick Install (Single Copy-Paste Block)

> Recommended for Ubuntu 20.04 / 22.04 / 24.04.

```bash
# 1) System update + core packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
  git curl wget unzip build-essential cmake gdb \
  python3-pip python3-venv \
  ripgrep xclip wl-clipboard \
  software-properties-common \
  luarocks lua5.1 liblua5.1-0-dev

# 2) Neovim (0.10+)
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim

# 3) Node.js 20.x + providers/tools
sudo apt purge -y nodejs npm 2>/dev/null || true
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g neovim tree-sitter-cli
pip3 install --user pynvim

# 4) C++ language server
sudo apt install -y clangd

# 5) JetBrainsMono Nerd Font
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz
rm -f JetBrainsMono.tar.xz
fc-cache -fv
cd ~

# 6) Clone config
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
git clone https://github.com/FurkannByrm/nvim-dots ~/.config/nvim

# 7) Launch Neovim
nvim
```

---

## Step-by-Step Installation

### 1) Update System

```bash
sudo apt update && sudo apt upgrade -y
```

### 2) Install Core Dependencies

```bash
sudo apt install -y \
  git curl wget unzip build-essential cmake gdb \
  python3-pip python3-venv \
  ripgrep xclip wl-clipboard \
  software-properties-common \
  luarocks lua5.1 liblua5.1-0-dev
```

| Package | Purpose |
|---|---|
| `git` | Clone and manage config/plugins |
| `build-essential` | Build tools (`gcc/g++/make`) |
| `cmake` | Generate `compile_commands.json` |
| `gdb` | Debugger backend for DAP |
| `ripgrep` | Fast project-wide search |
| `luarocks`, `lua5.1` | Lua plugin dependencies |
| `xclip`, `wl-clipboard` | Clipboard integration (X11/Wayland) |

### 3) Install Neovim (>= 0.10)

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim
```

Verify:
```bash
nvim --version
```

### 4) Install Node.js (>= 20) + Neovim Providers

```bash
# Remove old Node.js versions if any
sudo apt purge -y nodejs npm 2>/dev/null || true

# Install Node.js 20.x
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Install Node provider + tree-sitter CLI
sudo npm install -g neovim tree-sitter-cli

# Install Python provider
pip3 install --user pynvim
```

### 5) Install Clangd

```bash
sudo apt install -y clangd
```

### 6) Install JetBrainsMono Nerd Font

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz
rm -f JetBrainsMono.tar.xz
fc-cache -fv
```

Set your terminal font to **JetBrainsMono Nerd Font**.

### 7) Clone the Configuration

```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
git clone https://github.com/FurkannByrm/nvim-dots ~/.config/nvim
```

---

## First Launch

```bash
nvim
```

On first launch, wait for `lazy.nvim` to finish installing plugins.  
Then restart Neovim once.

---

## Project Setup for C++ and ROS 2

For proper `clangd` indexing, generate a `compile_commands.json` in your project/workspace root.

### Standard CMake Projects

```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -B build
ln -sf build/compile_commands.json .
```

### ROS 2 (colcon) Workspaces

```bash
colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -sf build/<PACKAGE_NAME>/compile_commands.json .
```

---

## Keybindings

> Leader key: `Space`

### File Management (Neo-tree)

| Keybinding | Action |
|---|---|
| `<leader>e` | Toggle file explorer |
| `a` | Create file/folder |
| `d` | Delete |
| `r` | Rename |
| `x / c / p` | Cut / Copy / Paste |
| `H` | Toggle hidden files |
| `s / v` | Open in horizontal / vertical split |

### Window Navigation

| Keybinding | Action |
|---|---|
| `:vsplit` (`:vsp`) | Vertical split |
| `:split` (`:sp`) | Horizontal split |
| `Ctrl+w h/j/k/l` | Move between windows |
| `Ctrl+w r` | Rotate layout |
| `Ctrl+d / Ctrl+u` | Half-page down / up |
| `zz` | Center current line |
| `gg / G` | Top / bottom of file |

### Header / Source Switching (a.vim)

| Keybinding / Command | Action |
|---|---|
| `ga` | Toggle `.cpp` ↔ `.hpp` |
| `:AV` | Open alternate file (vertical split) |
| `:AS` | Open alternate file (horizontal split) |

### LSP, Diagnostics, Editing

| Keybinding | Action |
|---|---|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `gl` | Line diagnostics popup |
| `<leader>d` | Diagnostic popup |
| `]d / [d` | Next / previous diagnostic |
| `<leader>xx` | Toggle Trouble diagnostics |
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle comment for selection |
| `ysw"` | Surround word with `"` |
| `ds"` | Delete surrounding `"` |

### Debugging (nvim-dap)

| Keybinding | Action |
|---|---|
| `<leader>b` | Toggle breakpoint |
| `<F5>` | Start / continue |
| `<F10>` | Step over |
| `<F11>` | Step into |

---

## Health Check

Inside Neovim:

```vim
:checkhealth
```

Confirm:

- `vim.provider`: Python and Node providers are active
- `nvim-treesitter`: `tree-sitter-cli` is detected
- `luarocks`: installed and detected
- `clipboard`: `xclip` (X11) or `wl-clipboard` (Wayland) is available

---

## Troubleshooting

### Provider warnings (`vim.provider`)

```bash
pip3 install --user --upgrade pynvim
sudo npm install -g neovim
```

### `tree-sitter-cli` not found

```bash
sudo npm install -g tree-sitter-cli
```

Alternative:
```bash
cargo install tree-sitter-cli
```

### Clipboard not working

For X11:
```bash
sudo apt install -y xclip
```

For Wayland:
```bash
sudo apt install -y wl-clipboard
```

---

## Repository

- https://github.com/FurkannByrm/nvim-dots
