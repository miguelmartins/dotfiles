return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false, -- neo-tree will lazily load itself
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		-- fill any relevant options here
	},
	keys = {
		{
			"<leader>b",
			function()
				require("neo-tree.command").execute({
					source = "buffers",
					position = "left",
				})
			end,
			desc = "Buffers (root dir)",
		},
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({
					source = "filesystem",
					position = "left",
				})
			end,
			desc = "Filesystem (root dir)",
		},
	}, -- Add git status as well but see if it does not mess with leader gf bind
	window = {
		mappings = {
			["h"] = function(state)
				local node = state.tree:get_node()
				if node.type == "directory" and node:is_expanded() then
					require("neo-tree.sources.filesystem").toggle_directory(state, node)
				else
					require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
				end
			end,
			["l"] = function(state)
				local node = state.tree:get_node()
				local path = node:get_id()
				if node.type == "directory" then
					if not node:is_expanded() then
						require("neo-tree.sources.filesystem").toggle_directory(state, node)
					elseif node:has_children() then
						require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
					end
				end
				if node.type == "file" then
					require("neo-tree.utils").open_file(state, path)
				end
			end,
		},
	},
	config = function(opts)
		require("neo-tree").setup(opts)
	end,
}
