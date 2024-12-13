return {
  "stevearc/aerial.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("aerial").setup({
      layout = { min_width = 30 },
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
        "Property",
        "Field",
        "Variable",
        "Constant",
        "TypeParameter",
      },
    })

    vim.keymap.set("n", "<leader>at", "<cmd>AerialToggle<CR>", { desc = "Aerial toggle" })
  end,
}
