local filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python" }

return {
  {
    "axelvc/template-string.nvim",
    opts = function(_, opts)
      opts.filetypes = filetypes -- filetypes where the plugin is active
      opts.jsx_brackets = true -- must add brackets to jsx attributes
      opts.remove_template_string = false -- remove backticks when there are no template string
      opts.restore_quotes = {
        -- quotes used when "remove_template_string" option is enabled
        normal = [[']],
        jsx = [["]],
      }
    end,
    ft = filetypes,
  },
}
