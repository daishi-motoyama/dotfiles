return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local treesj = require("treesj")
    local keymap = vim.keymap

    treesj.setup({
      use_default_keymaps = false,
    })

    keymap.set("n", "<leader>m", require("treesj").toggle)
  end,
}
