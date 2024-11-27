return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {},
  keys = {
    {
      "<leader>?",
      function()
        local wk = require("which-key")
        wk.show({ global = true })
      end,
      desc = "Global Keymaps (which-key)",
    },
    {
      "<leader>?l",
      function()
        local wk = require("which-key")
        wk.show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local wk = require("which-key")
    local icon = require("which-key.icons")

    wk.add({
      {
        "<leader>e",
        group = "Tree",
        icon = "🌲",
      },
      {
        "<leader>t",
        group = "Translate",
        icon = "󰗊",
      },
      {
        "<leader>f",
        group = "Telescope",
      },
      {
        "<leader>w",
        group = "Session",
      },
      {
        "<leader>s",
        group = "Window",
      },
      {
        "<leader>T",
        group = "Tab",
      },
      {
        "<leader>l",
        group = "LSP",
        icon = "💉",
      },
      {
        "<leader>x",
        group = "Trouble",
        icon = "⚠",
      },
      {
        "<leader>F",
        group = "Format",
        icon = "🌊",
      },
      {
        "<leader>g",
        group = "LazyGit",
        icon = "",
      },
      {
        "<leader>H",
        group = "Gitsigns",
        icon = "",
      },
      {
        "<leader>h",
        group = "Hop",
        icon = "🚀",
      },
      {
        "<leader>n",
        group = "No Highlight",
        icon = "󰸱",
      },
      {
        "<leader>b",
        group = "Buffer",
      },
      {
        "<leader>c",
        group = "Copilot",
        icon = "",
      },
    })
  end,
}
