return {
  "jinh0/eyeliner.nvim",
  event = "BufEnter",
  opts = {
    highlight_on_key = true,
    disabled_buftypes = { "nofile" },
    default_keymaps = true,
  },
  config = function(_, opts)
    require("eyeliner").setup(opts)

    vim.api.nvim_set_hl(0, "EyelinerPrimary", { bg = "Yellow", fg = "Black" })
    vim.api.nvim_set_hl(0, "EyelinerSecondary", { bg = "Red", fg = "Black" })
  end,
}
