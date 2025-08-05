return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    -- Auto-generate groups based on existing keymaps
    local function create_dynamic_groups()
      local groups = {}
      local seen_prefixes = {}

      -- Get all existing keymaps using current API
      local modes = { "n", "v", "x" }
      local keymaps = vim.iter(modes)
        :map(function(mode)
          return vim.api.nvim_get_keymap(mode)
        end)
        :flatten()
        :totable()

      -- Extract prefixes and create groups
      for _, keymap in pairs(keymaps) do
        local lhs = keymap.lhs

        -- Handle <leader> prefixes
        if lhs:match("^<leader>") and #lhs > 8 then
          local prefix = lhs:match("^<leader>(.)")
          if prefix and not seen_prefixes["<leader>" .. prefix] then
            seen_prefixes["<leader>" .. prefix] = true

            -- Map common prefixes to descriptive names
            local prefix_names = {
              z = "Code Folding",
              x = "Lists/Diagnostics",
              c = "Code Actions",
              u = "UI Toggles",
              g = "Git",
              b = "Buffers",
              f = "Files",
              s = "Search",
              r = "Replace/Substitute",
              p = "Split Actions/Wrap",
              h = "Harpoon",
              y = "Yank History",
              e = "File Explorer",
              o = "Other.nvim",
              ["/"] = "Comments",
            }

            table.insert(groups, {
              "<leader>" .. prefix,
              desc = prefix_names[prefix] or string.upper(prefix) .. " operations",
            })
          end
        end

        -- Handle <localleader> prefixes
        if lhs:match("^<localleader>") and not seen_prefixes["<localleader>"] then
          seen_prefixes["<localleader>"] = true
          table.insert(groups, { "<localleader>", desc = "Window Resize" })
        end

        -- Handle other common prefixes
        local common_prefixes = {
          ["g"] = "Go operations",
          ["]"] = "Next",
          ["["] = "Previous",
          ["s"] = "Substitute",
        }

        for prefix, desc in pairs(common_prefixes) do
          if lhs:match("^" .. vim.pesc(prefix)) and #lhs > 1 and not seen_prefixes[prefix] then
            seen_prefixes[prefix] = true
            table.insert(groups, { prefix, desc = desc })
          end
        end
      end

      return groups
    end

    wk.setup({
      preset = "helix",
      delay = false, -- Disable auto-trigger, only manual trigger
      win = {
        -- Position window at bottom-right
        row = math.huge, -- Position at bottom
        col = math.huge, -- Position at right
        no_overlap = true, -- Prevent overlap with cursor
        border = "rounded", -- Border style
        padding = { 1, 2 }, -- Extra window padding [top/bottom, left/right]
        title = " Which Key ", -- Add title
        title_pos = "center", -- Center the title
        wo = {
          winblend = 50, -- High transparency (50% transparent)
          winhighlight = "Normal:Pmenu,FloatBorder:Function", -- Use standard highlight groups
        },
      },
      -- Disable all triggers - only manual activation
      triggers = {}, -- Empty triggers array
      show = {
        keys = "all", -- Show all keybindings but filter them
        timeout = true, -- Show timeout indicator
      },
      expand = 1, -- Expand keybindings automatically
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = false, -- Disable operator pending mode
          motions = false, -- Disable motion mappings
          text_objects = false, -- Disable text object mappings
          windows = true, -- Default window mappings
          nav = true, -- Navigation mappings
          z = true, -- z mappings
          g = true, -- g mappings
        },
      },
    })

    -- Add dynamic groups
    local dynamic_groups = create_dynamic_groups()
    wk.add(dynamic_groups)

    -- Add some specific mappings that might not be auto-detected
    wk.add({
      { "<leader>w", hidden = true }, -- Hide save command
      { "?", hidden = true }, -- Hide the which-key trigger itself
      { "<leader>v", "v", desc = "Enter visual mode" },
      { "<leader><leader>", desc = "Swap Buffers" }, -- Double leader

      -- Buffer mappings (show both custom and potential defaults)
      { "<leader>b", mode = "v", desc = "Wrap selection in brackets" },
      { "<leader>bC", desc = "Close all buffers" },
      -- Potential LazyVim defaults (if active)
      { "<leader>bb", desc = "Switch to Other Buffer" },
      { "<leader>bd", desc = "Delete Buffer" },
      { "<leader>bo", desc = "Delete Other Buffers" },

      -- Visual wrapping keymaps
      { "<leader>p", mode = "v", desc = "Wrap selection in parentheses" },
      { "<leader>B", mode = "v", desc = "Wrap selection in braces" },
    })
  end,
  keys = {
    {
      "?",
      function()
        -- Show only important keymaps
        require("which-key").show({ 
          keys = "<leader>", -- Start with leader keys
          loop = true 
        })
      end,
      mode = { "n", "v" }, -- Only normal and visual modes
      desc = "Which Key (Important Keymaps)",
    },
    {
      "<leader>?",
      function()
        -- Show all keymaps
        require("which-key").show({ 
          global = true, 
          loop = true 
        })
      end,
      desc = "Which Key (All Keymaps)",
    },
  },
}
