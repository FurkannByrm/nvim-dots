return {
  -- 1. File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = "Toggle File Explorer" })
    end
  },

  -- 2. Smart Commenting (gcc to comment, gc in visual mode)
  {
    'numToStr/Comment.nvim',
    opts = {},
    config = function()
      require('Comment').setup()
    end
  },

  -- 3. Floating Terminal (Ctrl + \ to open)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = 'float',
        float_opts = { border = 'curved' }
      })
    end
  }
}


-- a: new file (when you write a name and then if put / it creates a directory).

-- d: deletes file

-- r: (Rename).

-- c: (Copy).

-- m:  (Move).

-- y: copy path.
