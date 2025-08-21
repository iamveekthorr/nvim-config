return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "helix",
      delay = 300, -- Small delay to show keymaps automatically
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true, -- Enable operator pending mode (shows s, d, y, etc.)
          motions = false, -- Keep motion mappings disabled
          text_objects = true, -- Enable text object mappings (shows a, i, etc.)
          windows = true, -- Default window mappings
          nav = true, -- Navigation mappings
          z = true, -- z mappings
          g = true, -- g mappings
        },
      },
      triggers = {
        { "<auto>", mode = "nxso" }, -- Auto-trigger in normal, visual, select, operator modes
        { "<leader>", mode = { "n", "v" } }, -- Show for leader key
        { "s", mode = { "n", "v" } }, -- Show for substitute keymaps
      },
    })

    -- Add group descriptions for common prefixes
    wk.add({
      -- Leader key groups
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Code" },
      { "<leader>f", group = "Files" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>r", group = "Replace/Substitute" },
      { "<leader>s", group = "Search" },
      { "<leader>u", group = "UI" },
      { "<leader>x", group = "Diagnostics" },
      { "<leader>y", group = "Yank" },

      -- Non-leader groups
      { "s", group = "Substitute" },
      { "g", group = "Go" },
      { "]", group = "Next" },
      { "[", group = "Previous" },

      -- Hide some noisy keymaps
      { "<leader>w", hidden = true },
      { "?", hidden = true },
    })
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Which Key (All Keymaps)",
    },
  },
}
