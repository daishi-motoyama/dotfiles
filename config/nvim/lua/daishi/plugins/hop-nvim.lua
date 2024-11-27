return {
  "smoka7/hop.nvim",
  version = "*",
  config = function()
    local hop = require("hop")
    local directions = require("hop.hint").HintDirection
    local keymap = vim.keymap

    keymap.set({ "n", "v", "o" }, "f", "<cmd>HopChar1CurrentLineAC<CR>")
    keymap.set({ "n", "v", "o" }, "F", "<cmd>HopChar1CurrentLineBC<CR>")
    keymap.set({ "n", "v", "o" }, "t", function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end, { remap = true })
    keymap.set({ "n", "v", "o" }, "T", function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    end, { remap = true })
    keymap.set("n", "<leader>hw", "<cmd>HopWord<CR>", { desc = "Hop word" })
    keymap.set("n", "<leader>hp", "<cmd>HopPattern<CR>", { desc = "Hop pattern" })
    keymap.set("n", "<leader>hv", "<cmd>HopVertical<CR>", { desc = "Hop vertical" })
    keymap.set("n", "<leader>ha", "<cmd>HopAnywhere<CR>", { desc = "Hop anywhere" })
    keymap.set("n", "<leader>hl", "<cmd>HopLineStart<CR>", { desc = "Hop line start" })

    hop.setup({
      jump_on_sole_occurrence = false,
      case_insensitive = false,
      multi_windows = true,
    })
  end,
}
