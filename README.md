# Neovim Configuration

Follow these steps in order to set up this Neovim configuration on a fresh Ubuntu (20.04 / 22.04 / 24.04) installation.

---

## Step 1 — Update the System

```bash
sudo apt update && sudo apt upgrade -y
```

## Step 2 — Install Core Dependencies

```bash
sudo apt install -y git curl wget unzip build-essential cmake gdb python3-pip ripgrep xclip software-properties-common
```

| Package | Why It's Needed |
|---------|----------------|
| `git` | Plugin manager (Lazy.nvim) clones all plugins via git |
| `curl`, `wget` | Download operations (Node.js, fonts, etc.) |
| `unzip` | Required by Mason LSP manager to extract packages |
| `build-essential` | `make`, `gcc`, `g++` — avante.nvim build step and C++ development |
| `cmake` | Generate `compile_commands.json` for CMake projects |
| `gdb` | C++ debugging via DAP (Debug Adapter Protocol) |
| `python3-pip` | Python tooling |
| `ripgrep` | Fast in-file search |
| `xclip` | Neovim → system clipboard copy (`"+y`) |
| `software-properties-common` | Required to add PPAs |

## Step 3 — Install Neovim (≥ 0.10)

The default Ubuntu repositories ship a very old Neovim version. Install the latest from the PPA:

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim
```

Verify the installation:

```bash
nvim --version
# Should show v0.10+
```

## Step 4 — Install Node.js (≥ 20)

Copilot and some LSP servers require Node.js.

```bash
# Remove old Node/npm if present
sudo apt purge -y nodejs npm 2>/dev/null
sudo rm -rf /usr/lib/node_modules /usr/local/lib/node_modules

# Install Node.js 20.x LTS
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
```

Verify the installation:

```bash
node -v   # v20.x+
npm -v    # 10.x+
```

## Step 5 — Install Clangd (C++ LSP)

```bash
sudo apt install -y clangd
```

> **Note:** On Ubuntu 20.04 you may need to install a newer version explicitly:
> ```bash
> sudo apt install -y clangd-14
> sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-14 100
> ```

## Step 6 — Install a Nerd Font (for icons)

Plugins (nvim-web-devicons, Neo-tree) use a **Nerd Font** to render icons. Without one, icons will appear as broken characters.

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# Download JetBrainsMono Nerd Font
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz
rm -f JetBrainsMono.tar.xz

# Rebuild font cache
fc-cache -fv
```

Then change the font in your **terminal application settings** to **JetBrainsMono Nerd Font**.

## Step 7 — Clone the Configuration

```bash
# Back up existing config if present
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Clone this repository
git clone https://github.com/YOUR_USERNAME/REPO_NAME ~/.config/nvim
```

## Step 8 — First Launch (Plugin Installation)

```bash
nvim
```

On the first launch **Lazy.nvim** will automatically download and install all plugins. This may take a few minutes.

- Treesitter parsers are installed automatically (`cpp`, `c`, `lua`, `cmake`, `bash`, `markdown`).
- Mason checks and installs the `clangd` LSP server.
- **avante.nvim** runs its `make` build step.

> Close and reopen Neovim after the installation finishes.

## Step 9 — GitHub Copilot Authentication

You need a GitHub Copilot subscription to use the AI features.

```
:Copilot auth
```

Sign in with your GitHub account in the browser window that opens and authorize.

## Step 10 — Health Check

Verify everything is installed correctly inside Neovim:

```
:checkhealth
```

Key checkpoints:

- **clipboard** → `xclip` should be found
- **Node.js** → `node` should be found
- **Treesitter** → parsers should be installed
- **LSP (clangd)** → should be running

---

## Quick Install (Single Copy-Paste Block)

Run all the steps at once:

```bash
# 1) Update system + install core packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl wget unzip build-essential cmake gdb python3-pip ripgrep xclip software-properties-common

# 2) Neovim (unstable PPA)
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update && sudo apt install -y neovim

# 3) Node.js 20.x
sudo apt purge -y nodejs npm 2>/dev/null
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# 4) Clangd
sudo apt install -y clangd

# 5) Nerd Font
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz && rm -f JetBrainsMono.tar.xz
fc-cache -fv

# 6) Clone config
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
git clone https://github.com/YOUR_USERNAME/REPO_NAME ~/.config/nvim

# 7) Launch Neovim (plugins install automatically)
nvim
```

> **Important:** After the first `nvim` launch, close and reopen Neovim, then run `:Copilot auth` to sign in.

---

## LSP Configuration (Per-Project)

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

### Navigation & Scrolling

#### Page Scrolling

| Key | Action |
|-----|--------|
| `Ctrl + d` | Scroll half page down |
| `Ctrl + u` | Scroll half page up |
| `Ctrl + f` | Scroll full page down (forward) |
| `Ctrl + b` | Scroll full page up (back) |
| `Ctrl + e` | Scroll screen down without moving cursor |
| `Ctrl + y` | Scroll screen up without moving cursor |

#### Cursor Positioning on Screen

| Key | Action |
|-----|--------|
| `zz` | Center current line on screen |
| `zt` | Move current line to top of screen |
| `zb` | Move current line to bottom of screen |

> **Tip:** Press `zz` when you find a function to center it and see the surrounding code.

#### Jump to Screen Edges

| Key | Action |
|-----|--------|
| `H` | Jump to the top (High) of the visible screen |
| `M` | Jump to the middle of the visible screen |
| `L` | Jump to the bottom (Low) of the visible screen |

#### Jump to File Positions

| Key | Action |
|-----|--------|
| `gg` | Jump to the first line of the file |
| `G` | Jump to the last line of the file |
| `150G` | Jump directly to line 150 |

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
