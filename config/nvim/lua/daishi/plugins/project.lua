return {
	"ahmedkhalf/project.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	event = "VeryLazy",
	config = function()
		require("telescope").load_extension("projects")
		require("project_nvim").setup()
	end,
}
