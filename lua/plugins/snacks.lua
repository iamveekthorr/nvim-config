local exclude_locs = { "node_modules", ".next", "dist", ".git" }
local lockfiles = {
  "yarn.lock",
  "pnpm-lock.yaml",
  "package-lock.json",
}

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = { enabled = false },
    terminal = { enabled = false },
    scroll = { enabled = false },
    animate = { enabled = false },
    picker = {
      sources = {
        explorer = {
          auto_close = true,
          layout = {
            preview = true,
            reverse = false,
            layout = {
              box = "horizontal",
              backdrop = true,
              width = 0.9,
              height = 0.9,
              border = "none",
              {
                box = "vertical",
                {
                  win = "input",
                  height = 1,
                  border = "rounded",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                },
                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
              },
              {
                win = "preview",
                title = "{preview:Preview}",
                width = 0.65,
                border = "rounded",
                title_pos = "center",
              },
            },
          },
        },
      },
      win = {
        input = {
          keys = {
            ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-b>"] = "",
            ["<c-f>"] = "",
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>E",
      function()
        Snacks.explorer({ cwd = LazyVim.root() })
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer Snacks (cwd)",
    },
    { "<leader>fe", false },
    { "<leader>fE", false },
    -- Snacks picker
    { "<leader><space>", false },
    { "<leader>/", false },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent({ filter = { cwd = true, show_untracked = true } })
      end,
      desc = "Recent (cwd)",
    },
    { "<leader>ff", LazyVim.pick("files", { root = false, show_untracked = true }), desc = "Find Files (Root Dir)" },
    {
      "<leader>fF",
      function()
        Snacks.picker.files({ hidden = true, ignored = true, exclude = exclude_locs, show_empty = true })
      end,
      desc = "Find Files (cwd)",
    },
    {
      "<leader>fR",
      LazyVim.pick("oldfiles"),
      desc = "Recent (All)",
    },
    { "<leader>s<cr>", "<cmd>FzfLua resume<cr>", desc = "Resume" },
    { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (Root Dir)" },
    {
      "<leader>sG",
      function()
        Snacks.picker.grep({ hidden = true, ignored = true, live = true, regex = true, exclude = exclude_locs })
      end,
      desc = "Grep (cwd)",
    },
    { "<leader>si", false },
    { "<leader>sR", false },
    {
      "<leader>s<cr>",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
  },
}
