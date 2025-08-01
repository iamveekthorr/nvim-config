return {
  "nvim-lualine/lualine.nvim",
  config = function(_, opts)
    local icons = LazyVim.config.icons

    local function get_hl_color(group, attr)
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
      if not ok or not hl then
        return nil
      end
      local color = hl[attr]
      if color then
        -- Mask the color to ensure it's a 24-bit value
        local hex_color = bit.band(color, 0x00FFFFFF)
        return string.format("#%06x", hex_color)
      end
      return nil
    end

    local function get_dynamic_colors()
      return {
        bg = get_hl_color("Normal", "bg"),
        fg = get_hl_color("Normal", "fg"),
        accent = get_hl_color("Identifier", "fg") or get_hl_color("Function", "fg"),
        warning = get_hl_color("WarningMsg", "fg"),
        error = get_hl_color("ErrorMsg", "fg"),
        info = get_hl_color("InfoMsg", "fg"),
        comment = get_hl_color("Comment", "fg"),
        string = get_hl_color("String", "fg"),
        keyword = get_hl_color("Keyword", "fg"),
        visual = get_hl_color("Visual", "bg"),
        search = get_hl_color("Search", "bg"),
        statusline_bg = get_hl_color("StatusLine", "bg"),
      }
    end

    local function get_mode_color()
      local colors = get_dynamic_colors()
      local mode = vim.fn.mode()

      if mode == "n" then
        return { gui = "bold", cterm = "bold", bg = colors.statusline_bg, fg = colors.bg }
      elseif mode == "i" then
        return { gui = "bold", cterm = "bold", bg = colors.string, fg = colors.bg }
      elseif mode == "v" or mode == "V" or mode == "" then
        return { gui = "bold", cterm = "bold", bg = colors.keyword, fg = colors.bg }
      elseif mode == "c" then
        return { gui = "bold", cterm = "bold", bg = colors.warning, fg = colors.bg }
      elseif mode == "R" then
        return { gui = "bold", cterm = "bold", bg = colors.error, fg = colors.bg }
      else
        return { gui = "bold", cterm = "bold", bg = colors.info, fg = colors.bg }
      end
    end

    local conditions = {
      buffer_not_empty_and_not_terminal = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 and vim.bo.buftype ~= "terminal"
      end,
    }

    local filename = {
      "filename",
      path = 1,
      cond = conditions.buffer_not_empty_and_not_terminal,
    }

    table.remove(opts.sections.lualine_x)
    table.remove(opts.sections.lualine_z)
    -- opts.tabline = opts.sections
    opts.sections.lualine_c = {
      LazyVim.lualine.root_dir(),
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
    }
    opts.component_separators = { left = "", right = "" }
    opts.section_separators = { left = "", right = "" }
    opts.always_show_tabline = false
    opts.sections = {
      lualine_a = {
        {
          "mode",
          icon = "",
          padding = 3,
          color = get_mode_color,
        },
      },
      lualine_b = {
        {
          "branch",
          padding = 2,
          color = function()
            local colors = get_dynamic_colors()
            return { fg = colors.string, bg = colors.statusline_bg or colors.visual, gui = "bold", cterm = "bold" }
          end,
        },
        {
          "diff",
          colored = true,
          diff_color = {
            added = function()
              local colors = get_dynamic_colors()
              return { fg = colors.string }
            end,
            modified = function()
              local colors = get_dynamic_colors()
              return { fg = colors.warning }
            end,
            removed = function()
              local colors = get_dynamic_colors()
              return { fg = colors.error }
            end,
          },
        },
      },
      lualine_c = {
        {
          function()
            return vim.fn.expand("%:~:.")
          end,
          padding = { left = 3, right = 3 },
          color = function()
            local colors = get_dynamic_colors()
            return { fg = colors.accent, bg = colors.visual, gui = "bold", cterm = "bold" }
          end,
        },
        {
          function()
            return "󰌪 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          end,
          padding = { left = 2, right = 2 },
          color = function()
            local colors = get_dynamic_colors()
            return { fg = colors.keyword, bg = colors.search, gui = "bold", cterm = "bold" }
          end,
        },
        {
          function()
            if vim.fn.empty(vim.fn.expand("%:t")) == 1 or vim.bo.buftype ~= "" then
              return ""
            end

            if vim.bo.modified then
              return "● Modified"
            elseif vim.bo.readonly then
              return "󰌾 Readonly"
            else
              return "󰄬 Saved"
            end
          end,
          padding = { left = 2, right = 2 },
          color = function()
            local colors = get_dynamic_colors()
            if vim.bo.modified then
              return { fg = colors.error, bg = colors.visual, gui = "bold", cterm = "bold" }
            elseif vim.bo.readonly then
              return { fg = colors.warning, bg = colors.visual, gui = "bold", cterm = "bold" }
            else
              return { fg = colors.string, bg = colors.visual, gui = "bold", cterm = "bold" }
            end
          end,
        },
      },
      lualine_x = {
        {
          -- Tracks the number of open tabs
          function()
            local buffers = vim.fn.len(vim.fn.filter(vim.fn.range(1, vim.fn.bufnr("$")), "buflisted(v:val)"))

            if vim.bo.buftype ~= "terminal" and vim.fn.empty(vim.fn.expand("%:t")) == 0 then
              return "󰓩  " .. "Open Buffers: " .. buffers
            else
              return ""
            end
          end,
          padding = { left = 2, right = 2 },
          color = function()
            local colors = get_dynamic_colors()
            return { fg = colors.info, bg = colors.search, gui = "bold", cterm = "bold" }
          end,
        },
        {
          -- File size
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
          padding = { left = 2, right = 2 },
          color = function()
            local colors = get_dynamic_colors()
            return { fg = colors.comment, bg = colors.visual, gui = "bold", cterm = "bold" }
          end,
        },
        {
          "filetype",
          icon_only = false,
          padding = { left = 3, right = 3 },
          color = function()
            local colors = get_dynamic_colors()
            return { fg = colors.string, bg = colors.visual, gui = "bold", cterm = "bold" }
          end,
        },
      },
      lualine_y = {
        {
          function()
            return string.format("≡ %d/%d", vim.fn.line("."), vim.fn.line("$"))
          end,
          padding = { left = 3, right = 3 },
          color = function()
            local colors = get_dynamic_colors()
            return { fg = colors.search, bg = colors.warning, gui = "bold", cterm = "bold" }
          end,
        },
      },
      lualine_z = {
        {
          function()
            return string.format("↕%d ≡ [%d]", vim.fn.line("."), vim.fn.col("."))
          end,
          padding = { left = 3, right = 3 },
          color = function()
            local colors = get_dynamic_colors()
            return { gui = "bold", cterm = "bold", bg = colors.error, fg = colors.bg }
          end,
        },
        {
          function()
            return "󱫒" .. " " .. vim.fn.strftime("%H:%M")
          end,
          padding = { left = 2, right = 2 },
          color = function()
            local colors = get_dynamic_colors()
            return { fg = colors.accent, bg = colors.visual, gui = "bold", cterm = "bold" }
          end,
        },
      },
    }
    opts.inactive_sections = {}
    opts.inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    }
    opts.winbar = {
      lualine_c = {
        {
          "filename",
          path = 1, -- 0 = just file name, 1 = relative path, 2 = absolute
          symbols = {
            modified = " ●",
            readonly = " ",
            unnamed = "",
          },
          cond = conditions.buffer_not_empty_and_not_terminal,
          color = function()
            local colors = get_dynamic_colors()
            return {
              fg = colors.accent or colors.fg,
              bg = colors.statusline_bg or colors.search or colors.visual,
              gui = "bold",
              cterm = "bold",
            }
          end,
          padding = 2,
        },
      },
    }

    opts.options.theme = "auto"

    require("lualine").setup(opts)
    vim.cmd([[set laststatus=3]])
  end,
}
