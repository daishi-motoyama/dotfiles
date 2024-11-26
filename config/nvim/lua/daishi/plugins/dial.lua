return {
  "monaqa/dial.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local dial = require("dial.map")
    local keymap = vim.keymap
    local augend = require("dial.augend")

    keymap.set("n", "<C-a>", function()
      dial.manipulate("increment", "normal")
    end)
    keymap.set("n", "<C-x>", function()
      dial.manipulate("decrement", "normal")
    end)
    keymap.set("n", "g<C-a>", function()
      dial.manipulate("increment", "gnormal")
    end)
    keymap.set("n", "g<C-x>", function()
      dial.manipulate("decrement", "gnormal")
    end)
    keymap.set("v", "<C-a>", function()
      dial.manipulate("increment", "visual")
    end)
    keymap.set("v", "<C-x>", function()
      dial.manipulate("decrement", "visual")
    end)
    keymap.set("v", "g<C-a>", function()
      dial.manipulate("increment", "gvisual")
    end)
    keymap.set("v", "g<C-x>", function()
      dial.manipulate("decrement", "gvisual")
    end)

    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.constant.alias.bool,
        augend.constant.alias.ja_weekday,
        augend.constant.alias.ja_weekday_full,
        augend.constant.new({
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        }),
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%H:%M"],
        augend.date.alias["%Y年%-m月%-d日"],
        augend.date.alias["%Y年%-m月%-d日(%ja)"],
        augend.constant.alias.de_weekday,
        augend.constant.alias.de_weekday_full,
      },
      typescript = {
        augend.constant.new({ elements = { "let", "const" } }),
      },
    })
  end,
}
