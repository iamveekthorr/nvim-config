return {
  "gbprod/substitute.nvim",
  event = "VeryLazy",
  config = function()
    local substitute = require("substitute")
    -- local wk = require("which-key")

    substitute.setup({
      on_substitute = require("yanky.integration").substitute(),
    })

    vim.keymap.set(
      { "n", "v" },
      "s",
      substitute.operator,
      { noremap = true, desc = "Substitute selection (with motion) with register content" }
    )

    vim.keymap.set(
      { "n", "v" },
      "ss",
      substitute.line,
      { noremap = true, desc = "Substitute line with register content" }
    )

    vim.keymap.set(
      { "n", "v" },
      "S",
      substitute.eol,
      { noremap = true, desc = "Substitute until end of line with register content" }
    )

    vim.keymap.set(
      "x",
      "s",
      substitute.visual,
      { noremap = true, desc = "Substitute selection (with motion) with register content" }
    )

    -- Range
    -- wk.add({ { "<leader>r", group = "Substitue range" } })
    vim.keymap.set("n", "<leader>r", require("substitute.range").operator, {
      noremap = true,
      desc = "Substitute selection (with motion) and destination (with motion) with input that would be specified",
    })

    vim.keymap.set("n", "<leader>rs", require("substitute.range").word, {
      noremap = true,
      desc = "Substitute word under cursor and destination (with motion) with input that would be specified",
    })

    vim.keymap.set("x", "<leader>r", require("substitute.range").visual, {
      noremap = true,
      desc = "Substitute selection (with motion) and destination (with motion) with input that would be specified",
    })

    -- Exchange
    vim.keymap.set("n", "sx", require("substitute.exchange").operator, { noremap = true })
    vim.keymap.set("n", "sxx", require("substitute.exchange").line, { noremap = true })
    vim.keymap.set("x", "X", require("substitute.exchange").visual, { noremap = true })
    vim.keymap.set("n", "sxc", require("substitute.exchange").cancel, { noremap = true })

    return vim
  end,
}
