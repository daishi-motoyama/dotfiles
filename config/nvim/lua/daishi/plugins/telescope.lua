return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-frecency.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    local toggle_modes = function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == "n" then
        vim.cmd([[startinsert]])
        return
      end
      if mode == "i" then
        vim.cmd([[stopinsert]])
        return
      end
    end

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-h>"] = "which_key",
            ["<esc>"] = actions.close,
            ["<C-space>"] = toggle_modes,
          },
          n = { ["<C-space>"] = toggle_modes },
        },
      },
      extensions = {
        frecency = {
          show_scores = true,
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("frecency")
    telescope.load_extension("yank_history")

    local function is_git_repo()
      vim.fn.system("git rev-parse --is-inside-work-tree")

      return vim.v.shell_error == 0
    end

    local function get_git_root()
      local dot_git_path = vim.fn.finddir(".git", ".;")
      return vim.fn.fnamemodify(dot_git_path, ":h")
    end

    function live_grep_from_project_git_root()
      local opts = {}

      if is_git_repo() then
        opts = {
          cwd = get_git_root(),
          path_display = { "absolute" },
        }
      end

      builtin.live_grep(opts)
    end

    function grep_string_from_project_git_root()
      local opts = {}
      if is_git_repo() then
        opts = {
          cwd = get_git_root(),
          path_display = { "absolute" },
        }
      end
      builtin.grep_string(opts)
    end

    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd>Telescope git_files<CR>", { desc = "Find files in git repository" })
    keymap.set("n", "<leader>fwc", "<cmd>Telescope live_grep<CR>", { desc = "Find word in cwd" })
    keymap.set(
      "n",
      "<leader>fwr",
      "<cmd>lua live_grep_from_project_git_root()<CR>",
      { desc = "Find word in project root" }
    )
    keymap.set("n", "<leader>fgc", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })
    keymap.set(
      "n",
      "<leader>fgr",
      "<cmd>lua grep_string_from_project_git_root()<CR>",
      { desc = "Find string under cursor in project root" }
    )
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todos" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope frecency workspace=CWD<CR>", { desc = "Find recent files" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope command_history<CR>", { desc = "Find command history" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find help tags" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find keymaps" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope search_history<CR>", { desc = "Find search history" })
    keymap.set("n", "<leader>fR", "<cmd>Telescope registers<CR>", { desc = "Find registersOpen file browser" })
    keymap.set("n", "<leader>fy", "<cmd>Telescope yank_history<CR>", { desc = "Find yank history" })
  end,
}
