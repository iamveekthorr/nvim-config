return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      nginx = { "nginxfmt" },
      nix = { "nixfmt" },
      toml = { "pyproject-fmt" },
      css = { "prettier" },
      scss = { "prettier" },
      rust = { "rustfmt" },
      go = { "gofmt" },
    },
  },
}
