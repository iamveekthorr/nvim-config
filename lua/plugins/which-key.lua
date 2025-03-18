return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<leader>w", hidden = true },
      { "gs", desc = "Surround" },
      { "gsa", desc = "Surround with ..." },
      { "gsd", desc = "Delete surrounding ..." },
      { "gsr", desc = "Replace surrounding ... with ..." },

      { "<leader>o", desc = "Other" },
    },
  },
}
