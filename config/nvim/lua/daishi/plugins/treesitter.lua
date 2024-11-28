return {
  "nvim-treesitter/nvim-treesitter",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

    treesitter.setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
            ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
            ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            ["ir"] = { query = "@return.inner", desc = "Select inner part of a return" },
            ["ar"] = { query = "@return.outer", desc = "Select outer part of a return" },
            ["ib"] = { query = "@block.inner", desc = "Select inner part of a block" },
            ["ab"] = { query = "@block.outer", desc = "Select outer part of a block" },
            ["ic"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
            ["ac"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["iC"] = { query = "@call.inner", desc = "Select inner part of a call" },
            ["aC"] = { query = "@call.outer", desc = "Select outer part of a call" },
            ["ip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
            ["ap"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
          },
        },
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-i>",
          node_incremental = "<C-i>",
          scope_incremental = false,
          node_decremental = "<C-d>",
        },
      },
    })
  end,
}
