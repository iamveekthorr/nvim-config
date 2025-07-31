return {
  {
    "folke/tokyonight.nvim",
    enabled = false,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      style = "night",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = true,
    config = function()
      require("catppuccin").setup({
        flavour = "auto", -- or latte, frappe, macchiato
        transparent_background = true,
        show_end_of_buffer = false,
        integrations = {
          cmp = true,
          nvimtree = true,
          treesitter = true,
          telescope = {
            enabled = true,
            style = nil,
          },
        },
        float = { transparent = true, solid = true },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          -- floats = "transparent",
        },
        custom_highlights = function(colors)
          return {
            Normal = { bg = "NONE" },
            NormalNC = { bg = "NONE" },
            CursorLine = { bg = "NONE" },
            SignColumn = { bg = "NONE" },
            LineNr = { bg = "NONE" },
            CursorLineNr = { bg = "NONE" },
            EndOfBuffer = { bg = "NONE" },
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE" },
            Pmenu = { bg = "NONE" },
            PmenuSel = { bg = "NONE", fg = colors.pink },
            WinSeparator = { bg = "NONE" },
          }
        end,
      })

      -- vim.cmd.colorscheme("catppuccin")

      -- Additional transparency settings
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      -- vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
    end,
  },

  {
    "scottmckendry/cyberdream.nvim",
    opts = {
      transparent = true,
      enabled = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      italic_comments = true,
    },
  },

  {
    "luisiacc/gruvbox-baby",
    config = function()
      vim.g.gruvbox_baby_transparent_mode = 1
      -- vim.g.gruvbox_baby_function_style = "strikethrough"
    end,
  },

  {
    "egerhether/heatherfield.nvim",
    opts = {
      transparent_background = true,
      custom_highlights = {
        StatusLine = { bg = "NONE", fg = "NONE" },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      defaults = {
        keymaps = false,
      },
    },
  },
}
