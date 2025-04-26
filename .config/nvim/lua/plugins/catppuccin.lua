return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("catppuccin")
		require("catppuccin").setup({})
		vim.cmd.colorscheme("catppuccin")

		-- Make line numbers more vibrant
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#f38ba8", bold = true })
		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#94e2d5", italic = true })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#94e2d5", italic = true })
	end,
}
