return {
  "rest-nvim/rest.nvim",
  event = "VeryLazy",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "json",
      callback = function(ev)
        vim.bo[ev.buf].formatprg = "jq"
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "http",
      callback = function()
        vim.schedule(function()
          vim.keymap.set(
            "n",
            "<leader>rr",
            "<cmd>Rest run<CR>",
            { buffer = true, desc = "Run request under the cursor" }
          )
          vim.keymap.set(
            "n",
            "<leader>res",
            "<cmd>Rest env show<CR>",
            { buffer = true, desc = "Show dotenv file registered to current .http file" }
          )
          vim.keymap.set("n", "<leader>reS", "<cmd>Rest env select", { buffer = true, desc = "Select env" })
        end)
      end,
    })
  end,
}
