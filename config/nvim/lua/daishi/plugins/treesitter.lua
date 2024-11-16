return {
	"nvim-treesitter/nvim-treesitter",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	dependencies = { "windwp/nvim-ts-autotag" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-i>",
					node_incremental = "<C-i>",
					scope_incremental = false,
					node_decremental = "<C-d>",
				},
			},
		})
	end,
}
