return {
  -- LSP & Autocomplete
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      require("mason").setup()

      -- Clangd capabilities
      local caps = require("cmp_nvim_lsp").default_capabilities()

      -- clangd-18 için UTF-16
      caps.offsetEncoding = { "utf-16" }

      -- Mason-lspconfig
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd" },

        handlers = {
          clangd = function()
            require("lspconfig").clangd.setup({
              capabilities = caps,

              -- SADECE Neovim için clangd 18
              cmd = {
                "clangd-18",
                "--background-index",
                "--clang-tidy",
                "--query-driver=/usr/bin/g++",
              },

              -- Projenin compile_commands.json dosyasını bul
              root_dir = require("lspconfig.util").root_pattern(
                "compile_commands.json",
                "compile_flags.txt",
                ".git"
              ),
            })
          end,
        },
      })

      -- Autocomplete
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }),
      })

      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )

      -- LSP Kısayolları
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
        desc = "Go to Definition",
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {
        desc = "Hover Documentation",
      })

      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
        desc = "Show Diagnostics",
      })
    end,
  },

  -- GDB Debugger (DAP)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "mi" },
      }

      dap.configurations.cpp = {
        {
          name = "Launch GDB",
          type = "gdb",
          request = "launch",

          program = function()
            return vim.fn.input(
              "Path: ",
              vim.fn.getcwd() .. "/build/",
              "file"
            )
          end,

          cwd = "${workspaceFolder}",
        },
      }

      vim.keymap.set("n", "<F5>", dap.continue)
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    end,
  },

  -- Trouble
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("trouble").setup()

      vim.keymap.set(
        "n",
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>"
      )
    end,
  },
}
