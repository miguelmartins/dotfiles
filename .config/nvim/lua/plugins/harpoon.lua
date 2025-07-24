return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})

			-- basic telescope configuration
			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end, { desc = "Harpoon: Add file" })

			-- Toggle Harpoon quick menu
			vim.keymap.set("n", "<leader>hh", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Harpoon: Quick menu" })

			-- Navigate directly to files (ergonomic home-row mappings)
			vim.keymap.set("n", "<leader>hj", function()
				harpoon:list():select(1)
			end, { desc = "Harpoon: Select file 1" })
			vim.keymap.set("n", "<leader>hk", function()
				harpoon:list():select(2)
			end, { desc = "Harpoon: Select file 2" })
			vim.keymap.set("n", "<leader>hl", function()
				harpoon:list():select(3)
			end, { desc = "Harpoon: Select file 3" })
			vim.keymap.set("n", "<leader>h;", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon: Select file 4" })

			-- Toggle between previous & next files in the Harpoon list
			vim.keymap.set("n", "<C-S-P>", function()
				harpoon:list():prev()
			end, { desc = "Harpoon: Previous file" })
			vim.keymap.set("n", "<C-S-N>", function()
				harpoon:list():next()
			end, { desc = "Harpoon: Next file" })
		end,
	},
}
