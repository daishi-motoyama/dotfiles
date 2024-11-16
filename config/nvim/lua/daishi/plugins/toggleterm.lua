return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local toggleterm = require("toggleterm")
    local Terminal = require("toggleterm.terminal").Terminal
    toggleterm.setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      -- c-\ を押せば Terminal を toggle する
      -- 2 c-\ を押せば 2 番目の terminal を開ける（番号を指定できる）
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      direction = "float",
    })

    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<c-\><c-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<c-\><c-n>]], opts)
    end

    local lazygit = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      hidden = true,
    })

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap("n", "<leader>gL", "<cmd>lua _lazygit_toggle()<CR>", { desc = "Open LazyGit" })
  end,
}
