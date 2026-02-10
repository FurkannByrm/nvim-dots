return {
  -- 1. TEMA: Tokyonight (C++ Kodlarını En İyi Gösteren Tema)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({ style = "storm", transparent = false })
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },

  -- 2. TREESITTER: Akıllı Renklendirme ve Analiz
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then return end
      configs.setup({
        -- Markdown parser hatalarını çözmek için [image_f33456.png]
        ensure_installed = { "cpp", "c", "lua", "cmake", "bash", "markdown", "markdown_inline" },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
      })
    end,
  },

  -- 3. HEADER/SOURCE GEÇİŞİ: a.vim
  -- Kısayol: 'ga' (Go Alternate) tuşuna basarak .cpp/.hpp arası geçiş yap
  { 
    "vim-scripts/a.vim", 
    event = "VeryLazy",
    config = function()
      vim.keymap.set('n', 'ga', ':A<CR>', { desc = "Header/Source Geçişi" })
    end
  },

  -- 4. SURROUND: Metni "" veya {} Arasına Alma
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup({}) end
  },

  -- 5. TROUBLE: Hataları ve Uyarıları Listeleme
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({})
      vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
    end
  },

  -- 6. NEO-TREE: Dosya Gezgini
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    config = function()
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>')
    end
  },

  -- 7. DİĞER TEMEL ARAÇLAR
  { "numToStr/Comment.nvim", config = function() require('Comment').setup() end },
  { "akinsho/toggleterm.nvim", version = "*", config = function() require("toggleterm").setup({ direction = 'float' }) end },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = function() require("nvim-autopairs").setup({}) end }
}


-- a: new file (when you write a name and then if put / it creates a directory).

-- d: deletes file

-- r: (Rename).

-- c: (Copy).

-- m:  (Move).

-- y: copy path.
