return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      char = {
        jump_labels = true,
        multi_line = false,
        highlight = {
          backdrop = false,
        },
      },
    },
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, false },
    { "S", mode = { "n", "x", "o" }, false },
    { "R", mode = { "o", "x" }, false },
  },
}
