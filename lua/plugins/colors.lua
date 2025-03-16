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
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").setup({
        transparent = true,
      })
      -- require("bamboo").load()
    end,
  },

  {
    "scottmckendry/cyberdream.nvim",
    opts = {
      transparent = true,
      italic_comments = true,
    },
  },

  {
    "diegoulloao/neofusion.nvim",
    opts = {
      transparent_mode = true,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
      defaults = {
        keymaps = false,
      },
    },
  },
}
