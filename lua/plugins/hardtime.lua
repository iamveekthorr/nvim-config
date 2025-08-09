return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    disabled_filetypes = { "snacks_input" },
    restricted_keys = {
      ["e"] = { "n", "x" },
      ["b"] = { "n", "x" },
      ["<BS>"] = { "", "i" },
      ["<Del>"] = { "", "i" },
    },
  },
}
