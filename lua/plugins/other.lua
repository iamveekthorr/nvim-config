local nestjs = {
  pattern = "/src/([a-zA-Z-_]*)/.*.ts$",
  target = {
    {
      target = "/src/%1/%1.service.spec.ts",
      context = "test",
    },
    {
      target = "/src/%1/%1.module.ts",
      context = "module",
    },
    {
      target = "/src/%1/%1.service.ts",
      context = "service",
    },
    {
      target = "/src/%1/%1.schema.ts",
      context = "schema",
    },
    {
      target = "/src/%1/%1.controller.ts",
      context = "controller",
    },
    {
      target = "/src/%1/\\(*.types.ts\\|*.type.ts\\)",
      context = "type",
    },
    {
      target = "/src/%1/\\(*.utils.ts\\|*.util.ts\\)",
      context = "util",
    },
    {
      target = "/src/%1/\\(*.tasks.ts\\|*.task.ts\\)",
      context = "task",
    },
    {
      target = "/src/%1/dtos/*.ts",
      context = "dtos",
    },
  },
}

local react = {
  {
    pattern = "(.*)/components/(.*)/(.*)([%.component]?).([tj]sx?)$",
    target = {
      {
        target = "%1/components/%2/\\(*.styles.ts\\|*.style.ts\\)",
        context = "style",
      },
    },
  },
  {
    pattern = "(.*)/components/(.*)/(.*).style([s]?).ts$",
    target = {
      {
        target = "%1/components/%2/\\(*.component.tsx\\|index.tsx\\)",
        context = "component",
      },
    },
  },
}

return {
  "rgroli/other.nvim",
  event = "VeryLazy",
  opts = {
    rememberBuffers = false,
    style = {
      newFileIndicator = "Create new:",
    },
  },
  keys = {
    { "<leader>oo", "<cmd>Other<cr>", desc = "Show other menu" },
    { "<leader>om", "<cmd>Other module<cr>", desc = "Go to other module" },
    { "<leader>os", "<cmd>Other service<cr>", desc = "Go to other service" },
    { "<leader>oa", "<cmd>Other schema<cr>", desc = "Go to other schema" },
    { "<leader>oc", "<cmd>Other controller<cr>", desc = "Go to other controller" },
    { "<leader>ot", "<cmd>Other type<cr>", desc = "Go to other type" },
    { "<leader>ou", "<cmd>Other util<cr>", desc = "Go to other util" },
  },
  config = function(_, opts)
    local mappings = { "golang", nestjs }

    for _, v in pairs(react) do
      table.insert(mappings, v)
    end

    opts.mappings = mappings
    require("other-nvim").setup(opts)
  end,
}
