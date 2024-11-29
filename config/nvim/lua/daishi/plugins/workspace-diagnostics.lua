-- @see https://github.com/folke/trouble.nvim/issues/379#issuecomment-2393094020

return {
  "artemave/workspace-diagnostics.nvim",
  event = "VeryLazy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "folke/trouble.nvim",
  },
  config = function()
    local wd = require("workspace-diagnostics")

    wd.setup({
      workspace_files = function()
        return vim.fn.systemlist("git ls-files")
      end,
    })

    vim.api.nvim_set_keymap("n", "<leader>xw", "", {
      noremap = true,
      callback = function()
        for _, client in ipairs(vim.lsp.get_clients()) do
          wd.populate_workspace_diagnostics(client, 0)
        end
      end,
      desc = "Populate workspace diagnostics",
    })
  end,
}
