return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },
    servers = {
      nginx_language_server = {},
      nil_ls = {},
      sqls = {
        on_attach = function(client, bufnr)
          local ok, sqls = pcall(require, "sqls")
          if ok then
            sqls.on_attach(client, bufnr)
          end
        end,
        root_dir = require("lspconfig.util").root_pattern(".sqls.yml", ".git", "."),
      },
    },
  },
}
