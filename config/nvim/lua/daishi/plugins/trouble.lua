return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  cmd = "Trouble",
  config = function()
    local trouble = require("trouble")
    local keymap = vim.keymap

    trouble.setup({
      focus = true,
    })

    keymap.set("n", "<leader>xt", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
    keymap.set(
      "n",
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
      { desc = "Buffer Diagnostics (Trouble)" }
    )
    keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle<CR>", { desc = "Symbols (Trouble)" })
    keymap.set(
      "n",
      "<leader>xl",
      "<cmd>Trouble lsp toggle win.position=right<CR>",
      { desc = "LSP Definitions / references / ... (Trouble)" }
    )
    keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>", { desc = "Location list (Trouble)" })
    keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix list (Trouble)" })
    keymap.set("n", "<leader>xT", "<cmd>TodoTrouble<CR>", { desc = "Open todos in trouble" })
  end,
}
