return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  opts = {
    modes = {
      lsp = {
        win = { position = "right" },
      },
    },
  },
  keys = {
    { "<leader>ce", "<cmd>Trouble lsp toggle focus<cr>", desc = "LSP references/definitions/... (Trouble)" },
    { "<leader>cS", false },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle focus filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle focus<cr>",
      desc = "Diagnostics (Trouble)",
    },
  },
}
