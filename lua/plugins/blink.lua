return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  opts = {
    keymap = {
      ["<Tab>"] = { "show" },
    },
    completion = {
      trigger = {
        show_on_keyword = false,
        show_on_trigger_character = false,
      },
    },
  },
}
