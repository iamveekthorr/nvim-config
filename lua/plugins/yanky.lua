return {
  "gbprod/yanky.nvim",
  event = "VeryLazy",
  keys = { { "<leader>p", false } },
  config = function()
    require("yanky").setup({
      ring = { ignore_registers = { "_", "+" } },
      system_clipboard = { sync_with_ring = false },
    })

    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Paste after cursor" })

    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Paste before cursor" })

    vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", { desc = "Cycle to next yanked item" })

    vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)", { desc = "Cycle to previous yanked item" })

    vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yank" })

    vim.keymap.set("n", "<leader>y", "<cmd>YankyRingHistory<cr>", { desc = "Show yank history " })

    return vim
  end,
}
