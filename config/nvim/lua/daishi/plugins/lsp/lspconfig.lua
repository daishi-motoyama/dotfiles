return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")

    local mason_lspconfig = require("mason-lspconfig")

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- カーソルにある word の参照箇所を調べる
        opts.desc = "Show LSP references"
        keymap.set("n", "<leader>lR", "<cmd>Telescope lsp_references<CR>", opts)

        -- 宣言箇所に移動する
        opts.desc = "Go to declaration"
        keymap.set("n", "<leader>lgD", vim.lsp.buf.declaration, opts)

        -- カーソルにある word の定義を調べる
        opts.desc = "Show LSP definitions"
        keymap.set("n", "<leader>lD", "<cmd>Telescope lsp_definitions<CR>", opts)

        -- カーソルにあるwordの実装を調べる
        opts.desc = "Show LSP implementations"
        keymap.set("n", "<leader>lI", "<cmd>Telescope lsp_implementations<CR>", opts)

        -- カーソルのにあるwordの型定義を調べる
        opts.desc = "Show LSP type definitions"
        keymap.set("n", "<leader>lT", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        -- 該当行でできるコードアクションを出す
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>lA", vim.lsp.buf.code_action, opts)

        -- 該当のwordをrenameする
        opts.desc = "Smart rename"
        keymap.set("n", "<leader>lN", vim.lsp.buf.rename, opts)

        -- 今開いているファイルのdiagnosticsを表示する
        opts.desc = "Show current file diagnostics"
        keymap.set("n", "<leader>ldC", "<cmd>Telescope diagnostics bufnf=0<CR>", opts)

        -- 該当行のdiagnosticsを表示する
        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>ldl", vim.diagnostic.open_float, opts)

        -- 前の診断箇所に移動する
        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "<leader>lgP", vim.diagnostic.goto_prev, opts)

        -- 次の診断箇所に移動する
        opts.desc = "Go to next diagnostic"
        keymap.set("n", "<leader>lgN", vim.diagnostic.goto_next, opts)

        -- カーソル位置のドキュメントを見る
        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "<leader>lK", vim.lsp.buf.hover, opts)

        -- リスタート
        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>lS", ":LspRestart<CR>", opts)
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["svelte"] = function()
        lspconfig["svelte"].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = { "*.js", "*.ts" },
              callback = function(ctx)
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
              end,
            })
          end,
        })
      end,
      ["graphql"] = function()
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,
      ["emmet_ls"] = function()
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            "svelte",
          },
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
      ["tailwindcss"] = function()
        lspconfig["tailwindcss"].setup({
          capabilities = capabilities,
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cva\\(([\\s\\S]*?)\\)(;|\\n)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "class:\\s*?[\"'`]([^\"'`]*).*?," },
                  { "([a-zA-Z0-9\\-:]+)" },
                },
              },
            },
          },
        })
      end,
      ["marksman"] = function()
        lspconfig["marksman"].setup({
          capabilities = capabilities,
        })
      end,
      ["yamlls"] = function()
        lspconfig["yamlls"].setup({
          capabilities = capabilities,
        })
      end,
    })
  end,
}
