return {
  -- Cursor benzeri AI deneyimi için ana eklenti
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Her zaman en son commit'i kullan
    opts = {
      -- SAĞLAYICI SEÇİMİ:
      -- Eğer GitHub Copilot aboneliğin varsa "copilot" olarak bırak.
      -- OpenAI API key'in varsa "openai" yapabilirsin (ayarlar gerekir).
      provider = "copilot", 
      copilot = {
        model = "gpt-4o", -- Copilot üzerinden GPT-4o kullanır
        temperature = 0,
        max_tokens = 4096,
      },
      behaviour = {
        auto_suggestions = false, -- Yazarken otomatik önerileri kapat (kafa karıştırabilir)
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
      },
      mappings = {
        --- KISAYOLLAR ---
        ask = "<leader>aa",     -- (Space + a + a) AI'ya soru sor (Chat panelini açar)
        edit = "<leader>ae",    -- (Space + a + e) Seçili kodu AI ile düzenle
        refresh = "<leader>ar", -- (Space + a + r) Cevabı yenile
      },
      hints = { enabled = true }, -- Tuş ipuçlarını göster
      windows = {
        position = "right",   -- Paneli sağ tarafta aç
        width = 30,           -- Genişlik yüzdesi
        sidebar_header = {
          align = "center",
          rounded = true,
        },
      },
    },
    -- Derleme aşaması (İlk kurulumda çalışır)
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim", -- Daha şık diyalog kutuları için
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- Copilot entegrasyonu için gerekli ---
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false }, -- Avante'nin kendi önerilerini kullanacağız
            panel = { enabled = false },
          })
        end,
      },
    },
  },

  -- Arayüzü güzelleştirmek için yardımcı eklenti (opsiyonel ama önerilir)
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
}
