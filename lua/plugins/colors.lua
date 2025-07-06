return {
  {
    "folke/tokyonight.nvim",
    enabled = true,
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
    "scottmckendry/cyberdream.nvim",
    opts = {
      transparent = true,
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
      colorscheme = "tokyonight",
      defaults = {
        keymaps = false,
      },
    },
  },
}
