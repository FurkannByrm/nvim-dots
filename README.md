# Neovim Configuration

Temiz bir Ubuntu (20.04 / 22.04 / 24.04) üzerine bu Neovim konfigürasyonunu kurmak için aşağıdaki adımları sırasıyla takip edin.

---

## Adım 1 — Sistemi Güncelle

```bash
sudo apt update && sudo apt upgrade -y
```

## Adım 2 — Temel Bağımlılıkları Kur

```bash
sudo apt install -y git curl wget unzip build-essential cmake gdb python3-pip ripgrep xclip software-properties-common
```

| Paket | Neden Gerekli |
|-------|---------------|
| `git` | Plugin yöneticisi (Lazy.nvim) tüm eklentileri git ile çeker |
| `curl`, `wget` | İndirme işlemleri (Node.js, font vb.) |
| `unzip` | Mason LSP yöneticisinin paketleri açması için |
| `build-essential` | `make`, `gcc`, `g++` — avante.nvim derleme adımı ve C++ geliştirme |
| `cmake` | CMake projelerinde `compile_commands.json` üretmek için |
| `gdb` | DAP (Debug Adapter Protocol) ile C++ hata ayıklama |
| `python3-pip` | Python araçları |
| `ripgrep` | Hızlı dosya içi arama |
| `xclip` | Neovim → sistem panoya kopyalama (`"+y`) |
| `software-properties-common` | PPA eklemek için gerekli |

## Adım 3 — Neovim Kur (≥ 0.10)

Ubuntu varsayılan depolarındaki Neovim çok eski. Güncel sürümü PPA'dan kuruyoruz:

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim
```

Kurulumu doğrula:

```bash
nvim --version
# v0.10+ çıkmalı
```

## Adım 4 — Node.js Kur (≥ 20)

Copilot ve bazı LSP sunucuları Node.js gerektirir.

```bash
# Varsa eski Node/npm'i kaldır
sudo apt purge -y nodejs npm 2>/dev/null
sudo rm -rf /usr/lib/node_modules /usr/local/lib/node_modules

# Node.js 20.x LTS kur
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
```

Kurulumu doğrula:

```bash
node -v   # v20.x+
npm -v    # 10.x+
```

## Adım 5 — Clangd Kur (C++ LSP)

```bash
sudo apt install -y clangd
```

> **Not:** Ubuntu 20.04'te `clangd` yerine `clangd-12` veya daha yüksek sürüm kurmanız gerekebilir:
> ```bash
> sudo apt install -y clangd-14
> sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-14 100
> ```

## Adım 6 — Nerd Font Kur (İkonlar için)

Eklentiler (nvim-web-devicons, Neo-tree) ikon gösterebilmek için bir **Nerd Font** kullanır. Terminal fontunu değiştirmezsek ikonlar bozuk görünür.

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# JetBrainsMono Nerd Font indir
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz
rm -f JetBrainsMono.tar.xz

# Font önbelleğini güncelle
fc-cache -fv
```

Ardından **terminal uygulamanın ayarlarından** fontu **JetBrainsMono Nerd Font** olarak değiştir.

## Adım 7 — Konfigürasyonu Kopyala

```bash
# Varsa eski config'i yedekle
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Bu repoyu klonla
git clone https://github.com/YOUR_USERNAME/REPO_NAME ~/.config/nvim
```

## Adım 8 — İlk Çalıştırma (Eklenti Kurulumu)

```bash
nvim
```

İlk açılışta **Lazy.nvim** otomatik olarak tüm eklentileri indirir ve kurar. Bu işlem birkaç dakika sürebilir.

- Treesitter parser'ları otomatik indirilir (`cpp`, `c`, `lua`, `cmake`, `bash`, `markdown`).
- Mason otomatik olarak `clangd` LSP'yi kontrol eder.
- **avante.nvim** için `make` komutu çalışır (derleme aşaması).

> Kurulum tamamlanınca Neovim'i kapatıp tekrar açın.

## Adım 9 — GitHub Copilot Kimlik Doğrulama

Copilot (AI özellikleri) kullanmak için GitHub Copilot aboneliğiniz olmalı.

```
:Copilot auth
```

Açılan tarayıcı penceresinden GitHub hesabınızla giriş yapın ve onaylayın.

## Adım 10 — Sağlık Kontrolü

Neovim içinde her şeyin doğru kurulduğunu doğrulayın:

```
:checkhealth
```

Kritik kontrol noktaları:

- **clipboard** → `xclip` bulunmalı
- **Node.js** → `node` bulunmalı
- **Treesitter** → parserlar yüklenmiş olmalı
- **LSP (clangd)** → çalışır durumda olmalı

---

## Hızlı Kurulum (Tek Komut — Kopyala-Yapıştır)

Tüm adımları tek seferde çalıştırmak istersen:

```bash
# 1) Sistem güncelle + temel paketler
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

# 6) Config'i klonla
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
git clone https://github.com/YOUR_USERNAME/REPO_NAME ~/.config/nvim

# 7) Neovim'i başlat (eklentiler otomatik kurulur)
nvim
```

> **Önemli:** İlk `nvim` açılışından sonra Neovim'i kapatıp tekrar açın, ardından `:Copilot auth` ile giriş yapın.

---

## LSP Konfigürasyonu (Proje Bazlı)

### CMake Projeleri

```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
ln -s build/compile_commands.json .
```

### ROS2 Projeleri

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
