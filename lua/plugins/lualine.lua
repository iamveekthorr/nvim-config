return {
  "nvim-lualine/lualine.nvim",
  config = function(_, opts)
    local icons = LazyVim.config.icons

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
    opts.tabline = opts.sections
    opts.tabline.lualine_c = {
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
    opts.sections = { lualine_a = {}, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = {} }
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
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    }

    require("lualine").setup(opts)
    vim.cmd([[set laststatus=0]])
  end,
}
