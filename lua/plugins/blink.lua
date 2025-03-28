return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  opts = {
    keymap = {
      ["<Tab>"] = { "show_and_insert", "select_next" },
      ["<C-c>"] = { "cancel" },
      ["<S-Tab>"] = { "select_prev" },
    },
    completion = {
      trigger = {
        show_on_keyword = false,
        show_on_trigger_character = false,
        show_on_insert_on_trigger_character = false,
        show_on_accept_on_trigger_character = false,
      },
      ghost_text = {
        enabled = false,
      },
    },
  },
}
