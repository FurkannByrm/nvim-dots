return {
  -- 1. TEMA: OneDark (joshdick/onedark.vim)
  {
    "joshdick/onedark.vim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Termguicolors desteğini aç (doğru renk tonları için şarttır)
      vim.opt.termguicolors = true
      vim.cmd([[colorscheme onedark]])
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
