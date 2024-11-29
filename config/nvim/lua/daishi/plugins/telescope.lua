return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope._extensions.file_browser.actions")

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
        file_browser = {
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              ["<C-a>"] = fb_actions.create,
              ["<S-CR>"] = false,
              ["<C-r>"] = fb_actions.rename,
              ["<C-m>"] = fb_actions.move,
              ["<C-y>"] = fb_actions.copy,
              ["<C-d>"] = fb_actions.remove,
              ["<C-o>"] = false,
              ["<C-g>"] = fb_actions.goto_parent_dir,
              ["<C-e>"] = false,
              ["<C-w>"] = fb_actions.goto_cwd,
              ["<C-t>"] = fb_actions.change_cwd,
              ["<C-f>"] = fb_actions.toggle_browser,
              ["<C-h>"] = fb_actions.toggle_hidden,
              ["<C-s>"] = fb_actions.toggle_all,
              ["<bs>"] = fb_actions.backspace,
            },
            ["n"] = {
              ["a"] = fb_actions.create,
              ["r"] = fb_actions.rename,
              ["m"] = fb_actions.move,
              ["y"] = fb_actions.copy,
              ["d"] = fb_actions.remove,
              ["o"] = false,
              ["g"] = fb_actions.goto_parent_dir,
              ["e"] = false,
              ["w"] = fb_actions.goto_cwd,
              ["t"] = fb_actions.change_cwd,
              ["f"] = fb_actions.toggle_browser,
              ["h"] = fb_actions.toggle_hidden,
              ["s"] = fb_actions.toggle_all,
            },
          },
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
    telescope.load_extension("file_browser")

    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd>Telescope git_files<cr>", { desc = "Find files in git repository" })
    keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find word" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fr", function()
      require("telescope").extensions.frecency.frecency({
        workspace = "CWD",
      })
    end, { desc = "Find recent files" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope command_history<cr>", { desc = "Find command history" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })
    keymap.set("n", "<leader>fC", "<cmd>Telescope colorscheme<cr>", { desc = "Find colorscheme" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope search_history<cr>", { desc = "Find search history" })
    keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "Open file browser" })
  end,
}
