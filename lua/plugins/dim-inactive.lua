return {
  "miversen33/sunglasses.nvim",
  event = "UIEnter",
  config = function()
    require("sunglasses").setup({
      filter_type = "SHADE",
      filter_percent = 0.65,
    })
    
    -- Refresh sunglasses when terminal closes and focus returns to code
    vim.api.nvim_create_autocmd("TermClose", {
      callback = function()
        vim.schedule(function()
          -- Wait a moment then trigger window events to refresh sunglasses
          vim.defer_fn(function()
            vim.api.nvim_exec_autocmds("WinEnter", {})
            vim.api.nvim_exec_autocmds("FocusGained", {})
          end, 50)
        end)
      end,
    })
  end,
}
