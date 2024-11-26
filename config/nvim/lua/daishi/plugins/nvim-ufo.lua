return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
          winblend = 0,
          maxheight = 30,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          jumpTop = "gg",
          jumpBot = "G",
        },
      },
    },
    init = function()
      vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.foldcolumn = "1"

      vim.keymap.set("n", "zp", function()
        require("ufo.preview"):peekFoldedLinesUnderCursor()
      end, { desc = "Preview folded lines under cursor" })
    end,
  },
}
