return {
  -- 1. TEMA: OneDark (Lua Sürümü)
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      require("onedark").setup({ style = "dark" })
      require("onedark").load()
    end,
  },

  -- 2. TREESITTER: Akıllı Renklendirme
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
        "sfr:../include",
        "sfr:../src",
        "sfr:../include/**",
        "sfr:../src/**",
        "reg:|src[/\\\\]|include/|",
        "reg:|include[/\\\\]|src/|",
        "sfr:.",
      }, ",")
      vim.g.alternateExtensions_hpp = "cpp,cc,cxx"
      vim.g.alternateExtensions_cpp = "hpp,h,hxx"
      vim.g.alternateExtensions_h = "cpp,cc,c,cxx"
      vim.g.alternateExtensions_cc = "hpp,h,hxx"
    end,
    config = function()
      vim.keymap.set("n", "ga", ":A<CR>", { desc = "Header/Source Toggle" })
    end,
  },


  -- 4. NEO-TREE: Dosya Gezgini
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")
    end,
  },

  -- 5. MULTI CURSOR
  { "mg979/vim-visual-multi", branch = "master" },

  -- 6. DİĞER TEMEL ARAÇLAR
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
  { "akinsho/toggleterm.nvim", version = "*", config = function() require("toggleterm").setup({ direction = "float" }) end },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = function() require("nvim-autopairs").setup({}) end },
}
