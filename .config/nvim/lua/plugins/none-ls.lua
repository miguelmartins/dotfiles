return {
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "jay-babu/mason-null-ls.nvim" },
		config = function()
			require("mason").setup()
			require("mason-null-ls").setup({
				ensure_installed = {
					-- Opt to list sources here, when available in mason.
				},
				automatic_installation = false,
				handlers = {},
			})
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier.with({ filetypes = { "html", "json", "yaml", "markdown" } }),
					null_ls.builtins.formatting.shfmt.with({ args = { "-i", "4" } }),
					null_ls.builtins.formatting.stylua,
				},
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
