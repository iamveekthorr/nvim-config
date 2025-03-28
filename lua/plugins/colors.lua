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
      vim.g.gruvbox_baby_function_style = "strikethrough"
    end,
  },

  {
    "aktersnurra/no-clown-fiesta.nvim",
    opts = {
      transparent = true,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-baby",
      defaults = {
        keymaps = false,
      },
    },
  },
}
