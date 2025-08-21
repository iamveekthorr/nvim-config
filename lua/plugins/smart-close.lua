return {
  dir = vim.fn.stdpath("config") .. "/lua",
  name = "smart-close",
  config = function()
    require("smart-close").setup()
  end,
}
