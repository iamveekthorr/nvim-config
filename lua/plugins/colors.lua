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
        CatppuccinOptions: "float",
        integrations = {
          cmp = true,
          nvimtree = true,
          treesitter = true,
          telescope = {
            enabled = true,
            style = "nvchad",
          },
        },
        highlight_overrides = {
          all = function(colors)
            return {
              NormalFloat = { bg = "NONE" },
              FloatBorder = { bg = "NONE" },
              FloatTitle = { bg = "NONE" },
              Pmenu = { bg = "NONE" },
              PmenuSel = { bg = colors.surface0 },
            }
          end,
        },
      })
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
