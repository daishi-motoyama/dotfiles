return {
  "neanias/everforest-nvim",
  priority = 1000,
  config = function()
    local everforest = require("everforest")
    everforest.setup({
      background = "soft",
      transparent_background_level = 0,
    })
    vim.cmd("colorscheme everforest")
  end,
}
