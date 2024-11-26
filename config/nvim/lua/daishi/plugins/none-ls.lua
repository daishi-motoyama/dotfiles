return {
  "nvimtools/none-ls.nvim",
  dependencies = { "gbprod/none-ls-shellcheck.nvim", "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local builtins = null_ls.builtins
    local null_ls_utils = require("null-ls.utils")
    local eslint_file = {
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.mjs",
      ".eslintrc.json",
      "eslint.config.mjs",
      "eslint.config.cjs",
      "eslint.config.js",
      "eslint.config.ts",
    }

    null_ls.setup({
      root_dir = null_ls_utils.root_pattern(".null-ls-root", ".neoconf.jsong", ".git", "package.json"),
      sources = {
        builtins.diagnostics.markdownlint_cli2,
        builtins.formatting.prettier.with({
          prefer_local = "node_modules/.bin",
        }),
        builtins.formatting.biome.with({
          prefer_local = "node_modules/.bin",
          condition = function(utils)
            return utils.root_has_file({ "biome.json" })
          end,
        }),
        builtins.formatting.stylua,
        builtins.completion.spell,
        require("none-ls.diagnostics.eslint_d").with({
          prefer_local = "node_modules/.bin",
          condition = function(utils)
            return utils.root_has_file(eslint_file)
          end,
        }),
        require("none-ls.code_actions.eslint_d").with({
          prefer_local = "node_modules/.bin",
          condition = function(utils)
            return utils.root_has_file(eslint_file)
          end,
        }),
        builtins.formatting.shfmt.with({
          filetypes = { "sh", "zsh" },
          extra_args = { "-i", "2", "-ci" },
        }),
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
      },
      diagnostics_format = "#{m} (#{s}: #{c})",
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                async = false,
                filter = function(c)
                  return c.name == "null-ls"
                end,
              })
            end,
          })
        end
      end,
    })
    vim.keymap.set("n", "<leader>F", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format" })
  end,
}
