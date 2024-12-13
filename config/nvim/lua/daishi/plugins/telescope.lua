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

    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd>Telescope git_files<CR>", { desc = "Find files in git repository" })
    keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Find word" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todos" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope frecency workspace=CWD<CR>", { desc = "Find recent files" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope command_history<CR>", { desc = "Find command history" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find help tags" })
    keymap.set("n", "<leader>fC", "<cmd>Telescope colorscheme<CR>", { desc = "Find colorscheme" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find keymaps" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope search_history<CR>", { desc = "Find search history" })
    keymap.set("n", "<leader>fR", "<cmd>Telescope registers<CR>", { desc = "Find registersOpen file browser" })
    keymap.set("n", "<leader>fy", "<cmd>Telescope yank_history<CR>", { desc = "Find yank history" })
  end,
}
