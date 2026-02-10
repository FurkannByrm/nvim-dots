return {
  -- LSP & Autocomplete & Snippets
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({ ensure_installed = { "clangd" } })

      local cmp = require("cmp")
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({ { name = "nvim_lsp" } }),
      })

      -- Parantezleri otomatik tamamlamak için cmp ile birleştir
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      -- Clangd (C++ LSP) Konfigürasyonu
      local caps = require("cmp_nvim_lsp").default_capabilities()
      caps.offsetEncoding = { "utf-16" }
      require("lspconfig").clangd.setup({
        capabilities = caps,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })

      -- LSP Kısayolları
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostics" })
    end,
  },

  -- GDB Debugging (DAP)
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      
      dap.adapters.gdb = { type = "executable", command = "gdb", args = { "-i", "mi" } }
      dap.configurations.cpp = {
        {
          name = "Launch GDB",
          type = "gdb",
          request = "launch",
          -- Proje binary yolunu build klasörü altında sorar
          program = function() return vim.fn.input("Path: ", vim.fn.getcwd() .. "/build/", "file") end,
          cwd = "${workspaceFolder}",
        },
      }

      vim.keymap.set("n", "<F5>", dap.continue)
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    end,
  },

  -- Trouble (Proje genelindeki hataları listeler)
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
      vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
    end,
  },
}
