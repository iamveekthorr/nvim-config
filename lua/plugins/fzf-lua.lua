return {
  "ibhagwan/fzf-lua",
  -- enabled = false,
  config = function(_, opts)
    local fzf = require("fzf-lua")
    local config = fzf.config

    -- Quickfix
    config.defaults.keymap.builtin["<c-u>"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-d>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-f>"] = ""
    config.defaults.keymap.builtin["<c-b>"] = ""

    fzf.setup(opts)
  end,
  keys = {},
  -- keys = {
  --   { "<leader><space>", false },
  --   { "<leader>/", false },
  --   {
  --     "<leader>fr",
  --     LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }),
  --     desc = "Recent (cwd)",
  --   },
  --   {
  --     "<leader>fR",
  --     "<cmd>FzfLua oldfiles<cr>",
  --     desc = "Recent (All)",
  --   },
  --   { "<leader>sR", false },
  --   { "<leader>s<cr>", "<cmd>FzfLua resume<cr>", desc = "Resume" },
  -- },
}
