return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    local bufferline = require("bufferline")

    local keymap = vim.keymap

    keymap.set("n", "<leader>bl", "<cmd>BufferLineCycleNext<CR>", { desc = "Go to Next Buffer" })
    keymap.set("n", "<leader>bh", "<cmd>BufferLineCyclePrev<CR>", { desc = "Go to Prev Buffer" })
    keymap.set("n", "<leader>bN1", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to the number 1 Buffer" })
    keymap.set("n", "<leader>bN2", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to the number 2 Buffer" })
    keymap.set("n", "<leader>bN3", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to the number 3 Buffer" })
    keymap.set("n", "<leader>bN4", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to the number 4 Buffer" })
    keymap.set("n", "<leader>bN5", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to the number 5 Buffer" })
    keymap.set("n", "<leader>bN6", "<cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to the number 6 Buffer" })
    keymap.set("n", "<leader>bN7", "<cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to the number 7 Buffer" })
    keymap.set("n", "<leader>bN8", "<cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to the number 8 Buffer" })
    keymap.set("n", "<leader>bN9", "<cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to the number 9 Buffer" })
    keymap.set("n", "<leader>bP", "<cmd>BufferLineTogglePin<CR>", { desc = "Buffer toggle pin" })
    keymap.set(
      "n",
      "<leader>bxal",
      "<cmd>BufferLineCloseRight<CR>",
      { desc = "Close all visible buffers to the right of the" }
    )
    keymap.set(
      "n",
      "<leader>bxah",
      "<cmd>BufferLineCloseLeft<CR>",
      { desc = "Close all visible buffers to the left of the" }
    )
    keymap.set("n", "<leader>bxao", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all other visible buffers" })
    keymap.set("n", "<leader>br", "<cmd>BufferLineTabRename<CR>", { desc = "Tab Rename" })

    keymap.set("n", "<leader>bxh", function()
      local buffer_id = vim.fn.bufnr()
      vim.cmd("BufferLineCyclePrev")
      vim.cmd("bdelete " .. buffer_id)
    end, { desc = "Close current buffer and go to previous" })

    keymap.set("n", "<leader>bxl", function()
      local buffer_id = vim.fn.bufnr()
      vim.cmd("BufferLineCycleNext")
      vim.cmd("bdelete " .. buffer_id)
    end, { desc = "Close current buffer and go to next" })

    bufferline.setup({
      options = {
        mode = "buffers",
        separator_style = "slant",
      },
    })
  end,
}
