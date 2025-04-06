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
vim.cmd([[filetype off]])
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.conf*]])
vim.cmd([[autocmd BufRead,BufNewFile *.conf,*.conf.template set filetype=nginx]])
vim.cmd([[autocmd FileType nginx setlocal iskeyword+=$]])
