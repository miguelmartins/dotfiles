return {
	{
		"saghen/blink.compat",
		version = "*", -- keep it in step with your blink.cmp version
		lazy = false, -- load on startup so the fake `cmp` exists early
		opts = {}, -- mandatory so :setup() runs
	},

	-- ② the vimtex completion source ------------
	{
		"micangl/cmp-vimtex",
		ft = "tex",
		-- make sure blink.compat is around first
		dependencies = { "saghen/blink.compat" },
	},
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ -- Autocompletion
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
			},
			"folke/lazydev.nvim",
			"micangl/cmp-vimtex",
		},
		lazy = true,
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				-- By default, you may press `<c-space>` to show the documentation.
				-- Optionally, set `auto_show = true` to show the documentation after a delay.
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},

			snippets = { preset = "luasnip" },
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
					vimtex = {
						-- if you used the compat shim:           ↓
						module = "blink.compat.source",
						score_offset = 100,
					},
				},
			},

			-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
			-- which automatically downloads a prebuilt binary when enabled.
			--
			-- By default, we use the Lua implementation instead, but you may enable
			-- the rust implementation via `'prefer_rust_with_warning'`
			--
			-- See :h blink-cmp-config-fuzzy for more information
			fuzzy = { implementation = "lua" },

			-- Shows a signature help window while you type arguments for a function
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
}
--  {
--    "L3MON4D3/LuaSnip",
--    dependencies = {
--      "saadparwaiz1/cmp_luasnip",
--      "rafamadriz/friendly-snippets",
--    },
--  },
--  {
--    "hrsh7th/nvim-cmp",
--    config = function()
--      local cmp = require("cmp")
--      require("luasnip.loaders.from_vscode").lazy_load()
--
--      cmp.setup({
--        snippet = {
--          expand = function(args)
--            require("luasnip").lsp_expand(args.body)
--          end,
--        },
--        window = {
--          completion = cmp.config.window.bordered(),
--          documentation = cmp.config.window.bordered(),
--        },
--        mapping = cmp.mapping.preset.insert({
--          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--          ["<C-f>"] = cmp.mapping.scroll_docs(4),
--          ["<C-Space>"] = cmp.mapping.complete(),
--          ["<C-e>"] = cmp.mapping.abort(),
--          ["<CR>"] = cmp.mapping.confirm({ select = true }),
--        }),
--        sources = cmp.config.sources({
--          { name = "nvim_lsp" },
--          { name = "luasnip" }, -- For luasnip users.
--        }, {
--          { name = "buffer" },
--        }),
--      })
--    end,
--  },
--}
