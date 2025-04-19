return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      nginx = { "nginxfmt" },
      nix = { "nil" },
      toml = { "pyproject-fmt" },
    },
  },
}
