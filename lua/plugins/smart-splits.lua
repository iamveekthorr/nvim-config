return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  dependencies = { "szw/vim-maximizer" },
  config = function()
    local smartsplits = require("smart-splits")
    -- local wk = require("which-key")

    smartsplits.setup({
      cursor_follows_swapped_bufs = true,
      at_edge = "wrap",
    })

    -- Close all splits when no file buffers are open
    vim.api.nvim_create_augroup("smart_splits_auto_close", { clear = true })
    vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
      group = "smart_splits_auto_close",
      callback = function(args)
        -- Don't trigger if it's a special buffer being deleted
        local deleted_buftype = vim.bo[args.buf].buftype
        local deleted_filetype = vim.bo[args.buf].filetype

        -- Only process deletion of normal file buffers
        if deleted_buftype ~= "" or deleted_filetype == "alpha" or deleted_filetype == "snacks_explorer" then
          return
        end

        vim.schedule(function()
          local bufs = vim.api.nvim_list_bufs()
          local file_buffer_count = 0

          for _, buf in ipairs(bufs) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
              local bufname = vim.api.nvim_buf_get_name(buf)
              local buftype = vim.bo[buf].buftype
              local filetype = vim.bo[buf].filetype
              local is_modified = vim.bo[buf].modified
              local line_count = vim.api.nvim_buf_line_count(buf)

              -- Count real file buffers (same logic as alpha.lua)
              if buftype == "" and filetype ~= "alpha" and filetype ~= "snacks_explorer" then
                if bufname ~= "" then
                  file_buffer_count = file_buffer_count + 1
                elseif is_modified then
                  file_buffer_count = file_buffer_count + 1
                elseif
                  line_count > 1 or (line_count == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] ~= "")
                then
                  file_buffer_count = file_buffer_count + 1
                end
              end
            end
          end

          -- Only close splits if there are no file buffers and we have multiple windows
          if file_buffer_count == 0 and vim.fn.winnr("$") > 1 then
            vim.cmd("only")
          end
        end)
      end,
    })

    -- Prevent splitting on alpha dashboard
    vim.api.nvim_create_autocmd("FileType", {
      group = "smart_splits_auto_close",
      pattern = "alpha",
      callback = function()
        vim.keymap.set("n", "<C-w>s", "<Nop>", { buffer = true })
        vim.keymap.set("n", "<C-w>v", "<Nop>", { buffer = true })
        vim.keymap.set("n", "\\", "<Nop>", { buffer = true })
        vim.keymap.set("n", "|", "<Nop>", { buffer = true })
      end,
    })

    -- these keymaps will also accept a range,
    -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
    vim.keymap.set("n", "<localleader>h", smartsplits.resize_left, { desc = "Resize left" })
    vim.keymap.set("n", "<localleader>j", smartsplits.resize_down, { desc = "Resize down" })
    vim.keymap.set("n", "<localleader>k", smartsplits.resize_up, { desc = "Resize up" })
    vim.keymap.set("n", "<localleader>l", smartsplits.resize_right, { desc = "Resize right" })

    -- moving between splits
    vim.keymap.set("n", "<C-h>", smartsplits.move_cursor_left, { desc = "Move cursor left", noremap = true })
    vim.keymap.set("n", "<C-j>", smartsplits.move_cursor_down, { desc = "Move cursor down" })
    vim.keymap.set("n", "<C-k>", smartsplits.move_cursor_up, { desc = "Move cursor up" })
    vim.keymap.set("n", "<C-l>", smartsplits.move_cursor_right, { desc = "Move cursor right" })

    -- wk.add({ "<leader><leader>", group = "Swap buffer" })

    vim.keymap.set("n", "<leader><leader>h", smartsplits.swap_buf_left, { desc = "Swap buffer left" })
    vim.keymap.set("n", "<leader><leader>j", smartsplits.swap_buf_down, { desc = "Swap buffer down" })
    vim.keymap.set("n", "<leader><leader>k", smartsplits.swap_buf_up, { desc = "Swap buffer up" })
    vim.keymap.set("n", "<leader><leader>l", smartsplits.swap_buf_right, { desc = "Swap buffer right" })

    -- wk.add({ "<leader>p", group = "Split actions" })

    vim.keymap.set({ "n", "v" }, "<leader>pm", "<cmd>MaximizerToggle!<CR>", { desc = "Toggle maximize current split" })

    vim.keymap.set("n", "<leader>pc", function()
      local buf = vim.api.nvim_get_current_buf()
      vim.cmd("close")
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = false })
      end
    end, { desc = "Close current split and buffer" })
  end,
}
