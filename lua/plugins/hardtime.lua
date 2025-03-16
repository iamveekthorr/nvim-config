return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    restricted_keys = {
      ["e"] = { "n", "x" },
      ["b"] = { "n", "x" },
      ["<BS>"] = { "", "i" },
      ["<Del>"] = { "", "i" },
    },
    disabled_keys = {
      ["<BS>"] = { "", "i" },
      ["<Del>"] = { "", "i" },
    },
  },
}
