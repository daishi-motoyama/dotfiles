return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    config = function()
      local copilot_chat = require("CopilotChat")
      local copilot_chat_select = require("CopilotChat.select")
      copilot_chat.setup({
        show_help = true,
        model = "claude-3.5-sonnet",
        window = {
          layout = "float",
          relative = "cursor",
          width = 1,
          height = 0.4,
          row = 1,
        },
        prompts = {
          Explain = {
            prompt = "/COPILOT_EXPLAIN コードを日本語で説明してください",
            mapping = "<leader>Ce",
            description = "explain the code",
          },
          Review = {
            prompt = "/COPILOT_REVIEW コードを日本語でレビューしてください。",
            mapping = "<leader>Cr",
            description = "review the code",
          },
          Fix = {
            prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
            mapping = "<leader>Cf",
            description = "fix the code",
          },
          Optimize = {
            prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
            mapping = "<leader>Co",
            description = "optimize the code",
          },
          Docs = {
            prompt = "/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを日本語で生成してください。",
            mapping = "<leader>Cd",
            description = "create code documentation",
          },
          Tests = {
            prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
            mapping = "<leader>Ct",
            description = "create test code",
          },
          FixDiagnostic = {
            prompt = "コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。",
            mapping = "<leader>Cd",
            description = "Fix the issue according to the code diagnostic results",
            selection = copilot_chat_select.diagnostics,
          },
          Commit = {
            prompt = [[             
              > #git:staged

              Avoid overly verbose descriptions or unnecessary details. Start with a short sentence in imperative form, no more than 50 characters long. Please write your commitments in Japanese. 

              Add a prefix based on the following Type to the short sentence and separate them with a colon. ex.) feat: add a function 

              Type Must be one of the following:

              ✨ feat: Introducing new features
              🐛 fix: Fixing a bug
              ⚡ perf: Improving performance
              📝 docs: Writing or updating documentation
              🎨 style: Improving structure/format of the code
              🛠️ build: Changes to the build system or dependencies
              ♻️ refactor: Refactoring code without changing functionality
              ✅ test: Adding or updating tests
              ➕ add: Adding a dependency
              ➖ remove: Removing a dependency
              🔥 delete: Removing code or files
              👷 ci: Changes to CI/CD configuration
              🔧 config: Changing configuration files
              💚 fix-ci: Fixing CI build issues
              🚑️ hotfix: Critical hotfix
              🚨 lint: Fixing linter warnings/errors
              🏷️ release: Releasing/Version tags
              📦️ package: Updating compiled files or packages
              💄 ui: Updating the UI and style files
              🎉 init: Initial commit
              🔧 tool: Adding or updating tooling
              👌 improve: General code improvements
              ✏️ typo: Fixing typos
              📈 analytics: Adding or updating analytics or tracking code
              📊 data: Working on data
              🌐 i18n: Internationalization and localization
              🗺️ map: Improving maps or navigation
              🔒 security: Fixing security issues
              🐳 docker: Work related to Docker
              🔊 log: Adding or updating logs
              🔇 mute: Removing logs
              🧪 experiment: Experimenting new things
              🚀 deploy: Deploying stuff
              🙈 ignore: Adding or updating .gitignore file
              📄 license: Adding or updating license
              🍎 osx: Fixing something on macOS
              🐧 linux: Fixing something on Linux
              🏁 windows: Fixing something on Windows
              🔤 text: Updating text and literals
              ⚗️ test: Experimenting code or features
              🎥 video: Adding or updating videos
              🍱 assets: Adding or updating assets
              🔖 tag: Adding or updating tags
              🌱 seed: Adding or updating seeds
              💡 idea: Adding comments/documenting ideas
            ]],
            mapping = "<leader>Cc",
            description = "Commit the staged changes",
          },
        },
      })

      function chat_buffer()
        local input = vim.fn.input("クイックチャット: ")
        if input ~= "" then
          copilot_chat.ask(input, { selection = copilot_chat_select.buffer })
        end
      end

      local keymap = vim.keymap

      keymap.set("n", "<leader>Cm", "<cmd>CopilotChatModels<CR>", { desc = "Select model" })
      keymap.set("n", "<leader>Cq", "<cmd>lua chat_buffer()<CR>", { desc = "Quick chat" })
    end,
  },
}
