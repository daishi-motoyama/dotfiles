return {
  "Wansmer/treesj",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local treesj = require("treesj")
    local keymap = vim.keymap

    treesj.setup({
      use_default_keymaps = false,
    })

    keymap.set("n", "gm", "", { desc = "Treesj" })
    keymap.set("n", "gmm", treesj.toggle, { desc = "Toggle split/join" })
  end,
}
