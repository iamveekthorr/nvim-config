-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- LazyNvim inspired
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- commenting
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- location list
vim.keymap.set("n", "<leader>xl", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })

-- quickfix list
vim.keymap.set("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  vim.keymap.set("n", "<leader>gg", function()
    Snacks.lazygit({ cwd = LazyVim.root.git() })
  end, { desc = "Lazygit (Root Dir)" })
  vim.keymap.set("n", "<leader>gG", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
  vim.keymap.set("n", "<leader>gf", function()
    Snacks.picker.git_log_file()
  end, { desc = "Git Current File History" })
  vim.keymap.set("n", "<leader>gl", function()
    Snacks.picker.git_log({ cwd = LazyVim.root.git() })
  end, { desc = "Git Log" })
  vim.keymap.set("n", "<leader>gL", function()
    Snacks.picker.git_log()
  end, { desc = "Git Log (cwd)" })
end

-- Normal mode
-- the mark preserves the cursor's current location
-- delm z deletes the mark
vim.keymap.set(
  "n",
  "J",
  "mzJ`z<cmd>delm z<cr>",
  { desc = "Join line below to current line and leave the cursor position as is" }
)

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Jump to next matching item and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Jump to previous matching item and center" })

vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Move to next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Move to previous buffer" })

vim.keymap.set("n", "<C-q>", "<cmd>qa!<CR>", { desc = "Quit nvim violently" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save buffer" })
vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "\\", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selections down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selections up" })

vim.keymap.set("n", "<leader><BS>", function()
  Snacks.bufdelete.delete()
end, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bC", function()
  Snacks.bufdelete.all()
end, { desc = "Close all buffers" })

-- Todo comments
vim.keymap.set("n", "gct", "o<esc>VcTODO: x<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add todo comment below" })
vim.keymap.set("n", "gcT", "O<esc>VcTODO: x<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add todo comment above" })
