return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Disable LazyVim's alpha integration
  enabled = function()
    return not vim.g.lazyvim_alpha_disabled
  end,
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Dynamic timing calculation based on system performance
    local function get_adaptive_delay()
      local start_time = vim.fn.reltime()
      -- Simple CPU-bound test to measure system responsiveness
      for i = 1, 1000 do
        local _ = math.sin(i)
      end
      local elapsed = vim.fn.reltimefloat(vim.fn.reltime(start_time))
      -- Base delay of 100ms, add more if system is slow
      return math.max(100, math.min(500, 100 + elapsed * 50000))
    end

    -- Set custom header with NEOVIM ASCII art
    dashboard.section.header.val = {
      "",
      "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
      "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
      "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
      "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "",
      "                  The hyperextensible Vim-based editor",
      "",
    }

    -- Create main action buttons
    dashboard.section.buttons.val = {
      dashboard.button("e", "󰈔  New File", "<cmd>ene<CR>"),
      dashboard.button("f", "󰱼  Find File", "<cmd>lua LazyVim.pick('files', { root = false })()<CR>"),
      dashboard.button("g", "  Find Word", "<cmd>lua LazyVim.pick('live_grep', { root = false })()<CR>"),
      dashboard.button(
        "r",
        "  Recent Files",
        "<cmd>lua require('snacks').picker.recent({ filter = { cwd = true } })<CR>"
      ),
      dashboard.button("x", "  File Explorer", "<cmd>lua require('snacks').explorer({ cwd = LazyVim.root() })<CR>"),
      dashboard.button("c", "  Configuration", "<cmd>edit $MYVIMRC<CR>"),
      dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
    }

    math.randomseed(os.time())

    -- Add inspirational quotes
    local quotes = {
      "Code is like humor. When you have to explain it, it's bad. - Cory House",
      "First, solve the problem. Then, write the code. - John Johnson",
      "Experience is the name everyone gives to their mistakes. - Oscar Wilde",
      "Knowledge is power. - Francis Bacon",
      "Code never lies, comments sometimes do. - Ron Jeffries",
      "Perfection is achieved not when there is nothing more to add, but rather when there is nothing more to take away. - Antoine de Saint-Exupery",
      "If debugging is the process of removing software bugs, then programming must be the process of putting them in. - Edsger Dijkstra",
      "Any fool can write code that a computer can understand. Good programmers write code that humans can understand. - Martin Fowler",
      "Programs must be written for people to read, and only incidentally for machines to execute. - Harold Abelson",
      "The best error message is the one that never shows up. - Thomas Fuchs",
      "Simplicity is the ultimate sophistication. - Leonardo da Vinci",
      "Make it work, make it right, make it fast. - Kent Beck",
      "Clean code always looks like it was written by someone who cares. - Robert C. Martin",
      "The only way to go fast is to go well. - Robert C. Martin",
      "Documentation is a love letter that you write to your future self. - Damian Conway",
    }

    -- Function to get a fresh random quote (called each time dashboard is shown)
    local function get_random_quote()
      return {
        "",
        quotes[math.random(#quotes)],
        "",
      }
    end

    -- Set initial quote as footer
    dashboard.section.footer.val = get_random_quote()

    -- Configure layout with better vertical centering
    local function calculate_vertical_padding()
      local total_lines = vim.o.lines
      local header_lines = #dashboard.section.header.val
      local content_lines = 12 -- Approximate lines for two-panel content
      local footer_lines = 3
      local total_content = header_lines + content_lines + footer_lines

      -- Calculate padding to center content
      local available_space = total_lines - total_content
      local top_padding = math.max(1, math.floor(available_space * 0.3)) -- 30% at top

      return top_padding
    end

    dashboard.config.layout = {
      { type = "padding", val = calculate_vertical_padding() },
      dashboard.section.header,
      { type = "padding", val = 3 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }

    -- Setup alpha
    alpha.setup(dashboard.config)

    -- Auto-open alpha when all buffers are closed with improved logic
    local function alpha_on_empty()
      -- Use adaptive delay instead of hardcoded 200ms
      local delay = get_adaptive_delay()

      vim.defer_fn(function()
        -- Don't show alpha if we're in certain buffer types
        local current_buf = vim.api.nvim_get_current_buf()
        local current_buftype = vim.bo[current_buf].buftype
        local current_filetype = vim.bo[current_buf].filetype

        -- Skip if we're in special buffers
        if current_buftype ~= "" and current_buftype ~= "nofile" then
          return
        end

        -- Skip if we're in explorer or other special filetypes
        if current_filetype == "snacks_explorer" or current_filetype == "neo-tree" or current_filetype == "alpha" then
          return
        end

        local bufs = vim.api.nvim_list_bufs()
        local count = 0
        local has_empty_unnamed = false

        for _, buf in ipairs(bufs) do
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
            local bufname = vim.api.nvim_buf_get_name(buf)
            local buftype = vim.bo[buf].buftype
            local filetype = vim.bo[buf].filetype
            local is_modified = vim.bo[buf].modified
            local line_count = vim.api.nvim_buf_line_count(buf)

            -- Count real file buffers AND any normal editing buffers (including unnamed)
            if
              buftype == ""
              and filetype ~= "alpha"
              and filetype ~= "snacks_explorer"
              and not bufname:match("alpha%-nvim")
            then
              -- Better handling of empty files
              if bufname ~= "" then
                -- Named file always counts
                count = count + 1
              elseif is_modified then
                -- Modified unnamed buffer counts
                count = count + 1
              elseif line_count > 1 or (line_count == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] ~= "") then
                -- Unnamed buffer with content counts
                count = count + 1
              else
                -- Track empty unnamed buffers separately
                has_empty_unnamed = true
              end
            end
          end
        end

        -- Show alpha if no file buffers, or only empty unnamed buffers exist
        local should_show_alpha = count == 0 and (current_buftype == "" or current_buftype == "nofile")

        -- Special handling: if user pressed 'e' and created empty buffer, allow closing it to return to alpha
        if should_show_alpha or (count == 0 and has_empty_unnamed and current_buftype == "") then
          -- Refresh the quote
          dashboard.section.footer.val = get_random_quote()
          vim.cmd("Alpha")
        end
      end, delay)
    end

    vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })

    -- Use BufDelete and BufWipeout but with more restrictive conditions
    vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
      group = "alpha_on_empty",
      callback = function(args)
        -- Don't trigger if it's a special buffer being deleted
        local buftype = vim.bo[args.buf].buftype
        local filetype = vim.bo[args.buf].filetype

        if buftype ~= "" or filetype == "alpha" or filetype == "snacks_explorer" then
          return
        end

        alpha_on_empty()
      end,
    })

    -- Disable folding on alpha buffer and prevent interference
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.foldenable = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.cursorline = false
      end,
    })

    -- Ensure alpha stays visible and prevent other plugins from opening
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        -- Refresh quote when alpha is shown
        dashboard.section.footer.val = get_random_quote()

        -- Prevent LazyVim from opening other buffers when alpha is shown
        vim.schedule(function()
          vim.cmd("doautocmd User LazyDone") -- Mark lazy as done to prevent interference
        end)
      end,
    })

    -- Refresh dashboard content when it becomes visible
    vim.api.nvim_create_autocmd("BufWinEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "alpha" then
          -- Refresh the dashboard content
          vim.defer_fn(function()
            dashboard.section.footer.val = get_random_quote()
            alpha.setup(dashboard.config)
          end, 50) -- Small delay to ensure proper refresh
        end
      end,
    })
  end,
}
