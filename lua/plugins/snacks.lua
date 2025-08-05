local exclude_locs = { "node_modules", ".next", "dist", ".git" }
local lockfiles = {
  "yarn.lock",
  "pnpm-lock.yaml",
  "package-lock.json",
}

return {
  "folke/snacks.nvim",
  config = function(_, opts)
    require("snacks").setup(opts)
    
    -- Clean integration with noice.nvim for dashboard
    local function show_dashboard_safe()
      vim.schedule(function()
        local file_bufs = vim.tbl_filter(function(buf)
          return vim.api.nvim_buf_is_valid(buf) 
            and vim.bo[buf].buflisted 
            and vim.bo[buf].buftype == ""
            and vim.api.nvim_buf_get_name(buf) ~= ""
        end, vim.api.nvim_list_bufs())
        
        -- Only show dashboard if no file buffers remain
        if #file_bufs == 0 then
          -- Simple approach: just create the dashboard
          -- Let noice handle its own UI state
          vim.defer_fn(function()
            pcall(function()
              require("snacks").dashboard()
            end)
          end, 50)
        end
      end)
    end
    
    vim.api.nvim_create_augroup("DashboardSafe", { clear = true })
    vim.api.nvim_create_autocmd("BufDelete", {
      group = "DashboardSafe",
      callback = show_dashboard_safe,
    })
  end,
  opts = {
    dashboard = {
      enabled = true,
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
      preset = {
        header = [[
██╗   ██╗███████╗███████╗██╗  ██╗████████╗██╗  ██╗ ██████╗ ██████╗ ██████╗  
██║   ██║██╔════╝██╔════╝██║ ██╔╝╚══██╔══╝██║  ██║██╔═══██╗██╔══██╗██╔══██╗ 
██║   ██║█████╗  █████╗  █████╔╝    ██║   ███████║██║   ██║██████╔╝██████╔╝ 
╚██╗ ██╔╝██╔══╝  ██╔══╝  ██╔═██╗    ██║   ██╔══██║██║   ██║██╔══██╗██╔══██╗ 
 ╚████╔╝ ███████╗███████╗██║  ██╗   ██║   ██║  ██║╚██████╔╝██║  ██║██║  ██║ 
  ╚═══╝  ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ 
        ]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    terminal = { enabled = false },
    scroll = { enabled = false },
    animate = { enabled = false },
    explorer = {
      replace_netrw = true,
    },
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
          win = {
            list = {
              wo = { relativenumber = true },
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
    { "<leader>E", false },
    {
      "<leader>e",
      function()
        Snacks.explorer({ cwd = LazyVim.root() })
      end,
      desc = "Open explorer",
    },
    {
      "<leader>D",
      function()
        require("snacks").dashboard()
      end,
      desc = "Dashboard",
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
    {
      "<leader>s<cr>",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
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
