-- NOTE: everforest
-- return {
--   "neanias/everforest-nvim",
--   priority = 1000,
--   config = function()
--     local everforest = require("everforest")
--     everforest.setup({
--       background = "soft",
--       transparent_background_level = 0,
--     })
--     vim.cmd("colorscheme everforest")
--   end,
-- }

-- NOTE: github-theme
return {
  "projekt0n/github-nvim-theme",
  name = "github-theme",
  lazy = false,
  priority = 1000,
  config = function()
    require("github-theme").setup()

    vim.cmd("colorscheme github_light")
  end,
}
