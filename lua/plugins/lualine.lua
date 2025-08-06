return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local icons = LazyVim.config.icons

    require("lualine").setup({
      options = {
        theme = {
          normal = {
            a = { bg = '#89b4fa', fg = '#1e1e2e', gui = 'bold' }, -- Blue bg for mode
            b = { bg = '#313244', fg = '#cdd6f4' }, -- Surface0 for secondary
            c = { bg = '#313244', fg = '#cdd6f4' }, -- Surface0 for tertiary
            x = { bg = '#45475a', fg = '#cdd6f4' }, -- Surface1 for right side
            y = { bg = '#585b70', fg = '#cdd6f4' }, -- Surface2 for position
            z = { bg = '#6c7086', fg = '#1e1e2e' }, -- Overlay0 for clock
          },
          insert = {
            a = { bg = '#a6e3a1', fg = '#1e1e2e', gui = 'bold' }, -- Green for insert
            b = { bg = '#313244', fg = '#cdd6f4' },
            c = { bg = '#313244', fg = '#cdd6f4' },
            x = { bg = '#45475a', fg = '#cdd6f4' },
            y = { bg = '#585b70', fg = '#cdd6f4' },
            z = { bg = '#6c7086', fg = '#1e1e2e' },
          },
          visual = {
            a = { bg = '#cba6f7', fg = '#1e1e2e', gui = 'bold' }, -- Mauve for visual
            b = { bg = '#313244', fg = '#cdd6f4' },
            c = { bg = '#313244', fg = '#cdd6f4' },
            x = { bg = '#45475a', fg = '#cdd6f4' },
            y = { bg = '#585b70', fg = '#cdd6f4' },
            z = { bg = '#6c7086', fg = '#1e1e2e' },
          },
          command = {
            a = { bg = '#f9e2af', fg = '#1e1e2e', gui = 'bold' }, -- Yellow for command
            b = { bg = '#313244', fg = '#cdd6f4' },
            c = { bg = '#313244', fg = '#cdd6f4' },
            x = { bg = '#45475a', fg = '#cdd6f4' },
            y = { bg = '#585b70', fg = '#cdd6f4' },
            z = { bg = '#6c7086', fg = '#1e1e2e' },
          },
        },
        globalstatus = true, -- Single statusline like VSCode
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
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
            icon = "⎇",
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
              return "󰌪 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
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
              local buffers = vim.fn.len(vim.fn.filter(vim.fn.range(1, vim.fn.bufnr("$")), "buflisted(v:val)"))
              if vim.bo.buftype ~= "terminal" and vim.fn.empty(vim.fn.expand("%:t")) == 0 then
                return "󰓩 " .. buffers .. " buffers"
              end
              return ""
            end,
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
              -- OS icon only
              if vim.fn.has("mac") == 1 then
                return ""
              elseif vim.fn.has("unix") == 1 then
                return ""
              elseif vim.fn.has("win32") == 1 then
                return ""
              else
                return ""
              end
            end,
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