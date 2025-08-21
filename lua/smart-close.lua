-- lua/smartclose/init.lua
local M = {}

-- Helper: check if buffer is a real "file buffer"
local function is_file_buffer(buf)
  return vim.api.nvim_buf_is_valid(buf)
    and vim.bo[buf].buflisted
    and vim.bo[buf].buftype == ""
    and vim.api.nvim_buf_get_name(buf) ~= ""
end

-- Helper: find the next most recently used buffer
-- that is not visible in any other window
local function find_next_buf(current_buf)
  local listed = vim.fn.getbufinfo({ buflisted = 1 })

  -- Sort by last used (descending, MRU style)
  table.sort(listed, function(a, b)
    return a.lastused > b.lastused
  end)

  for _, b in ipairs(listed) do
    if b.bufnr ~= current_buf and #vim.fn.win_findbuf(b.bufnr) == 0 then
      return b.bufnr
    end
  end

  return nil
end

-- Main logic: smart buffer + split closing
function M.smart_close()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()

  if not is_file_buffer(buf) then
    vim.notify("Not a file buffer", vim.log.levels.INFO)
    return
  end

  -- If buffer is shown in more than one window, just close this split
  local wins = vim.fn.win_findbuf(buf)
  if #wins > 1 then
    vim.api.nvim_win_close(win, true)
    return
  end

  -- Otherwise, look for a replacement buffer for this window
  local next_buf = find_next_buf(buf)

  if next_buf then
    -- Put next buffer in this window
    vim.api.nvim_win_set_buf(win, next_buf)
  else
    if #vim.api.nvim_list_wins() == 1 then
      -- Last window: create an empty scratch buffer
      vim.cmd("enew") -- opens a new empty buffer
      vim.bo.buftype = "nofile"
      vim.bo.bufhidden = "wipe"
      vim.bo.swapfile = false
    end
  end

  -- Delete the original buffer (safe)
  if vim.api.nvim_buf_is_valid(buf) then
    vim.cmd("bdelete " .. buf)
  end
end

-- Setup function (for keymaps and commands)
function M.setup(opts)
  opts = opts or {}

  local key = opts.keymap or "<leader><BS>"
  vim.keymap.set("n", key, M.smart_close, { desc = "Smart close buffer/split" })

  vim.api.nvim_create_user_command("SmartClose", function()
    M.smart_close()
  end, { desc = "Smart close buffer/split" })
end

return M
