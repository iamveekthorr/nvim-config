return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local icons = LazyVim.config.icons
    local theme = {
      normal = {
        a = { bg = "#89b4fa", fg = "#1e1e2e", gui = "bold" }, -- light blue
        b = { bg = "#1e1e2e", fg = "#cdd6f4", gui = "bold" }, -- dark bg, soft fg
        c = { bg = "#2c2f40", fg = "#bac2de" },
        x = { bg = "#2c2f40", fg = "#bac2de" },
        y = { bg = "#3b3f51", fg = "#bac2de" },
        z = { bg = "#89b4fa", fg = "#1e1e2e" }, -- match section a
      },
      insert = {
        a = { bg = "#a6e3a1", fg = "#1e1e2e", gui = "bold" }, -- mint green
        b = { bg = "#1e1e2e", fg = "#cdd6f4" },
        c = { bg = "#2c2f40", fg = "#bac2de" },
        x = { bg = "#2c2f40", fg = "#bac2de" },
        y = { bg = "#3b3f51", fg = "#bac2de" },
        z = { bg = "#a6e3a1", fg = "#1e1e2e" },
      },
      visual = {
        a = { bg = "#cba6f7", fg = "#1e1e2e", gui = "bold" }, -- soft purple
        b = { bg = "#1e1e2e", fg = "#cdd6f4" },
        c = { bg = "#2c2f40", fg = "#bac2de" },
        x = { bg = "#2c2f40", fg = "#bac2de" },
        y = { bg = "#3b3f51", fg = "#bac2de" },
        z = { bg = "#cba6f7", fg = "#1e1e2e" },
      },
      command = {
        a = { bg = "#f9e2af", fg = "#1e1e2e", gui = "bold" }, -- pastel yellow
        b = { bg = "#1e1e2e", fg = "#cdd6f4" },
        c = { bg = "#2c2f40", fg = "#bac2de" },
        x = { bg = "#2c2f40", fg = "#bac2de" },
        y = { bg = "#3b3f51", fg = "#bac2de" },
        z = { bg = "#f9e2af", fg = "#1e1e2e" },
      },
    }

    require("lualine").setup({
      options = {
        theme = theme,
        globalstatus = true, -- Single statusline like VSCode
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },

      sections = {
        -- Far left: Mode (like original config)
        lualine_a = {
          {
            "mode",
            icon = "",
            padding = { left = 1, right = 1 },
          },
        },

        -- Left side: Branch, diagnostics, folder (VSCode bottom-left style)
        lualine_b = {
          {
            "branch",
            icon = "",
            padding = { left = 1, right = 1 },
          },
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error .. " ",
              warn = icons.diagnostics.Warn .. " ",
              info = icons.diagnostics.Info .. " ",
              hint = icons.diagnostics.Hint .. " ",
            },
            padding = { left = 0, right = 1 },
          },
          {
            function()
              return "| "
            end,
            padding = { left = 0, right = 0 },
          },
          {
            function()
              return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            end,
            padding = { left = 0, right = 1 },
          },
        },

        -- Center-left: File status
        lualine_c = {
          {
            function()
              if vim.fn.empty(vim.fn.expand("%:t")) == 1 or vim.bo.buftype ~= "" then
                return ""
              end
              if vim.bo.modified then
                return "● Unsaved changes"
              elseif vim.bo.readonly then
                return "󰌾 Read-only"
              end
              return ""
            end,
            padding = { left = 1, right = 1 },
          },
        },

        -- Right side: File info, cursor position (VSCode bottom-right style)
        lualine_x = {
          {
            function()
              -- Only show Git user if we're inside a Git repo
              if vim.fn.isdirectory(".git") == 0 then
                return ""
              end

              local handle = io.popen("git config user.name 2>/dev/null")
              if not handle then
                return ""
              end

              local name = handle:read("*l")
              handle:close()

              if name and name ~= "" then
                return "  " .. "Git User - " .. name -- Git icon + username
              end
              return ""
            end,
            icon = nil,
            padding = { left = 1, right = 1 },
            color = theme.command.a,
          },
          {
            function()
              local buffers = vim.fn.len(vim.fn.filter(vim.fn.range(1, vim.fn.bufnr("$")), "buflisted(v:val)"))
              if vim.bo.buftype ~= "terminal" and vim.fn.empty(vim.fn.expand("%:t")) == 0 then
                return "󰓩 " .. " " .. buffers .. " buffer(s)"
              end
              return ""
            end,
            color = { fg = theme.normal.b.bg, bg = theme.normal.b.fg },
            padding = { left = 1, right = 1 },
          },
          {
            function()
              if vim.bo.buftype ~= "" or vim.fn.empty(vim.fn.expand("%:t")) == 1 then
                return ""
              end
              return vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
            end,
            padding = { left = 1, right = 1 },
          },
          {
            "filetype",
            icon_only = false,
            padding = { left = 1, right = 1 },
          },
          {
            function()
              local os = jit.os
              if os == "OSX" then
                return "   Mac" -- macOS
              elseif os == "Linux" then
                return "   Linux" -- Linux
              elseif os == "Windows" then
                return " 󰍲  Windows" -- Windows
              end
            end,
            color = { fg = theme.command.a.fg, bg = theme.command.a.bg },
            padding = { left = 1, right = 1 },
          },
          {
            function()
              local file = vim.fn.expand("%:p")
              if file == "" or vim.bo.buftype ~= "" then
                return ""
              end
              local size = vim.fn.getfsize(file)
              if size == -1 or size == -2 then
                return ""
              end

              local suffixes = { "B", "KB", "MB", "GB" }
              local i = 1
              while size > 1024 and i < #suffixes do
                size = size / 1024
                i = i + 1
              end
              return string.format("%.1f%s", size, suffixes[i])
            end,
            color = { fg = theme.normal.b.bg, bg = theme.normal.b.fg },
            padding = { left = 1, right = 1 },
          },
        },

        -- Far right: Line/column position
        lualine_y = {
          {
            function()
              return string.format("Ln %d, Col %d", vim.fn.line("."), vim.fn.col("."))
            end,
            padding = { left = 1, right = 1 },
          },
        },

        -- Clock (your current feature)
        lualine_z = {
          {
            function()
              return "󱫒 " .. vim.fn.strftime("%H:%M")
            end,
            padding = { left = 1, right = 1 },
          },
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },

      winbar = {
        lualine_c = {
          {
            "filename",
            path = 1, -- Show relative path
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "",
            },
            padding = 1,
            cond = function()
              return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 and vim.bo.buftype == ""
            end,
          },
        },
      },

      inactive_winbar = {
        lualine_c = {
          {
            "filename",
            path = 1,
            padding = 1,
          },
        },
      },
    })

    -- Global statusline
    vim.cmd([[set laststatus=3]])
  end,
}
