return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  opts = {
    keymap = {
      ["<C-p>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-c>"] = { "cancel" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },
    completion = {
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = false,
        show_on_insert_on_trigger_character = false,
        show_on_accept_on_trigger_character = false,
      },
      ghost_text = {
        enabled = true,
      },
    },
  },
}
