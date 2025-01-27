return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    "nvimdev/lspsaga.nvim",
    { "yioneko/nvim-vtsls", branch = "main" },
  },
  config = function()
    local lspconfig = require("lspconfig")

    local mason_lspconfig = require("mason-lspconfig")

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    require("lspsaga").setup({
      code_action = {
        extend_gitsigns = true,
      },
    })

    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- カーソルにある word の参照箇所を調べる
        opts.desc = "Show LSP references"
        keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", opts)

        -- 宣言箇所に移動する
        opts.desc = "Go to declaration"
        keymap.set("n", "<leader>lgd", vim.lsp.buf.declaration, opts)

        -- カーソルにある word の定義を調べる
        opts.desc = "Show LSP definitions"
        keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", opts)

        -- カーソルにあるwordの実装を調べる
        opts.desc = "Show LSP implementations"
        keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts)

        -- カーソルのにあるwordの型定義を調べる
        opts.desc = "Show LSP type definitions"
        keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        -- 該当行でできるコードアクションを出す
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>", opts)

        -- 該当のwordをrenameする
        opts.desc = "Smart rename"
        keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)

        -- 今開いているファイルのdiagnosticsを表示する
        opts.desc = "Show current file diagnostics"
        keymap.set("n", "<leader>ldc", "<cmd>Telescope diagnostics bufnf=0<CR>", opts)

        -- 該当行のdiagnosticsを表示する
        opts.desc = "Show line diagnostics"
        keymap.set({ "v", "n" }, "<leader>ldl", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)

        -- 参照と実装を確認
        opts.desc = "Show references and implementation."
        keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", opts)

        -- 前の診断箇所に移動する
        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "<leader>lgp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

        -- 次の診断箇所に移動する
        opts.desc = "Go to next diagnostic"
        keymap.set("n", "<leader>lgn", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

        -- カーソル位置のドキュメントを見る
        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "<leader>lk", "<cmd>Lspsaga hover_doc<CR>", opts)

        vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
          local locations = command.arguments[3]
          local client = vim.lsp.get_client_by_id(ctx.client_id)
          if locations and #locations > 0 then
            local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
            vim.fn.setloclist(0, {}, " ", { title = "References", items = items, context = ctx })
            vim.api.nvim_command("lopen")
          end
        end

        opts.desc = "Open up a quickfix window for references shown by the lens"
        keymap.set("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "typescript", "typescriptreact" },
      callback = function()
        vim.schedule(function()
          -- 今開いているファイルに不足しているimportを追加する
          keymap.set(
            "n",
            "<leader>lvi",
            "<cmd>VtsExec add_missing_imports<CR>",
            { buffer = true, desc = "Vtsls add missing imports" }
          )

          -- 実行できるコードアクションを表示する
          keymap.set(
            "n",
            "<leader>lva",
            "<cmd>VtsExec source_actions<CR>",
            { buffer = true, desc = "Vtsls source actions" }
          )
        end)
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
      ["bashls"] = function()
        lspconfig["bashls"].setup({
          capabilities = capabilities,
          filetypes = { "sh", "zsh" },
        })
      end,
      ["vtsls"] = function()
        lspconfig["vtsls"].setup({
          capabilities = capabilities,
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
        })
      end,
    })
  end,
}
