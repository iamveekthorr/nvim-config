-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Ression
-- local resession = require("resession")
--
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     -- Only load the session if nvim was started with no args
--     if vim.fn.argc(-1) == 0 then
--       -- Save these to a different directory, so our manual sessions don't get polluted
--       resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
--     end
--   end,
-- })
--
-- -- Save session before exiting
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   callback = function()
--     if vim.fn.argc(-1) == 0 then
--       resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
--     end
--   end,
-- })
-- Set filetype for nginx
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.conf*]])
vim.cmd([[autocmd BufRead,BufNewFile *.conf,*.conf.template set filetype=nginx]])
vim.cmd([[autocmd FileType nginx setlocal iskeyword+=$]])

-- Set comment for package name in file to avoid golint warnings
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
  pattern = "*.go",
  callback = function()
    vim.schedule(function()
      local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      if #buf_lines == 1 and buf_lines[1] == "" then
        local filepath = vim.fn.expand("%:p")
        local parent_dir = vim.fn.fnamemodify(filepath, ":h:t") -- get folder name
        local filename = vim.fn.expand("%:t:r") -- get file name without extension

        -- Use parent dir if not in root, else fallback to filename
        local relative_path = vim.fn.fnamemodify(filepath, ":.")

        local package_name = parent_dir
        if not relative_path:match(".-/") then
          package_name = filename
        end

        local lines = {
          "// Package " .. package_name .. " provides TODO: add description",
          "package " .. package_name,
          "",
        }
        vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
        vim.api.nvim_win_set_cursor(0, { 1, #vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] })
      end
    end)
  end,
})

-- Remove popup menu
vim.cmd([[
  aunmenu PopUp
  autocmd! nvim.popupmenu
]])

-- When closing a buffer in a split, close the split and keep remaining buffer as single window
-- vim.api.nvim_create_autocmd("BufDelete", {
--   callback = function()
--     local wins = vim.api.nvim_list_wins()
--     local tabwins = vim.tbl_filter(function(w)
--       return vim.api.nvim_win_get_tabpage(w) == vim.api.nvim_get_current_tabpage()
--     end, wins)
--
--     -- Only act if we have exactly 2 windows in the current tab
--     if #tabwins == 2 then
--       vim.schedule(function()
--         vim.cmd("only")
--       end)
--     end
--   end,
-- })

