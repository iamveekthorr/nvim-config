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

    local bg = get_hl_color("Normal", "bg")
    local fg = get_hl_color("Normal", "fg")
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
    opts.always_show_tabline = false
    opts.sections = {
      lualine_a = { { "mode", icon = "", padding = 1, color = { gui = "bold", bg, fg } } },
      lualine_b = { "branch", "diff" },
      lualine_c = {
        {
          "filename",
          cond = function()
            return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
          end,
        },
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
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
          color = { fg = fg, bg = bg },
        },
      },
    }

    opts.options.theme = "auto"

    require("lualine").setup(opts)
    vim.cmd([[set laststatus=3]])
  end,
}
