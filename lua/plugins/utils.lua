return {
  -- 1. TEMA: Tokyonight & Koyu Gri / Füme Alternatifler
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({ 
        style = "night", -- 'night' veya 'storm' mavi ton barındırır
        transparent = false 
      })
      -- vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  -- Alternatif 1: Kanagawa (Dragon varyantı tam aradığınız mat koyu gridir)
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({ theme = "dragon" })
      vim.cmd([[colorscheme kanagawa-dragon]]) -- ŞU AN AKTİF (Koyu Mat Gri)
    end,
  },

  -- Alternatif 2: Nightfox / Carbonfox (Tamamen nötr karbon/füme tonları)
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   vim.cmd([[colorscheme carbonfox]]) -- Kullanmak için yorumu kaldırın
    -- end,
  },

  -- Alternatif 3: Gruvbox Material (Klasik koyu füme/gri arka plan)
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_background = "hard" -- 'hard' veya 'medium'
    end,
    -- config = function()
    --   vim.cmd([[colorscheme gruvbox-material]]) -- Kullanmak için yorumu kaldırın
    -- end,
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
        ensure_installed = { "cpp", "c", "lua", "cmake", "bash", "markdown", "markdown_inline" },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
      })
    end,
  },

  -- 3. HEADER/SOURCE GEÇİŞİ: a.vim
  { 
    "vim-scripts/a.vim", 
    event = "VeryLazy",
    init = function()
      vim.g.alternateSearchPath = table.concat({
        "sfr:../include",        -- src/ -> include/
        "sfr:../src",            -- include/ -> src/
        "sfr:../include/**",     -- src/ -> include/alt_klasörler/
        "sfr:../src/**",         -- include/alt/ -> src/alt/
        "reg:|src[/\\\\]|include/|",   -- src/x.cpp -> include/x.hpp
        "reg:|include[/\\\\]|src/|",   -- include/x.hpp -> src/x.cpp
        "sfr:.",                 -- aynı klasör (fallback)
      }, ",")
      vim.g.alternateExtensions_hpp = "cpp,cc,cxx"
      vim.g.alternateExtensions_cpp = "hpp,h,hxx"
      vim.g.alternateExtensions_h = "cpp,cc,c,cxx"
      vim.g.alternateExtensions_cc = "hpp,h,hxx"
    end,
    config = function()
      vim.keymap.set('n', 'ga', ':A<CR>', { desc = "Header/Source Toggle" })
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

  -- 7. MULTI CURSOR
  { 'mg979/vim-visual-multi', branch = 'master' },

  -- 8. DİĞER TEMEL ARAÇLAR
  { "numToStr/Comment.nvim", config = function() require('Comment').setup() end },
  { "akinsho/toggleterm.nvim", version = "*", config = function() require("toggleterm").setup({ direction = 'float' }) end },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = function() require("nvim-autopairs").setup({}) end }
}
