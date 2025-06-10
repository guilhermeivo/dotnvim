vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1
vim.g.netrw_special_syntax = 1
vim.g.netrw_keepdir = true

vim.g.netrw_list_hide = '.*\\.git'

vim.g.mapleader = " "

vim.opt.title = true

vim.opt.number = true
vim.opt.mouse = "a"

vim.o.list = true
vim.opt.listchars = {
	tab = "▏ ",
	trail = "·"
}

vim.o.undofile = true
vim.o.undolevels = 10000

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.o.signcolumn = "yes:1"

vim.opt.fileencoding = "utf-8"

vim.opt.showmode = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.wrap = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.termguicolors = true

vim.cmd("colorscheme onehalf")
vim.cmd("set wildmenu")
vim.cmd("filetype plugin on")

function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<leader>v", ":vsplit")
map("n", "<leader>s", ":split")

-- open netrw in tree view
map("n", "<leader>b", ":25Lex<CR>")

-- pairs
map("i", "'", "''<left>")
map("i", "\"", "\"\"<left>")
map("i", "(", "()<left>")
-- map("i", "[", "[]<left>")
map("i", "{", "{}<left>")

-- comments
-- map("i", "/*", "/**/<left><left>")

