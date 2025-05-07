-- Remaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-i>", "<C-i>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-o>", "<C-o>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true })
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- tmux integration
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- temporary auto-import python solution
-- from kickstart.nvim
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- options
vim.opt.expandtab = true
vim.opt.guicursor = "n-v-c:block-Cursor/blinkon1"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8 -- never have less than 8 lines at eof
-- enable persistent undo
local undodir = vim.fn.stdpath("data") .. "/undo//"
if vim.fn.isdirectory(vim.fn.stdpath("data") .. "/undo") == 0 then
	vim.fn.mkdir(vim.fn.stdpath("data") .. "/undo", "p", tonumber("755", 8))
end
vim.opt.undofile = true
vim.opt.undodir = undodir
-- increase undo levels
vim.opt.undolevels = 10000
-- increase undo reload size
vim.opt.undoreload = 10000
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Add for vimtex compatability
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
