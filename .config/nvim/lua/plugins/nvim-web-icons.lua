return {
	{
		"echasnovski/mini.icons",
		version = false, -- or specify a version/tag
		config = function()
			require("mini.icons").setup()
		end,
	},
	{ "nvim-tree/nvim-web-devicons", opts = {} },
}
