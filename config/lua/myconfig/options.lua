-- Needs to be set early, for nvim tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ...
vim.o.termguicolors = true

-- I just love botright
vim.o.splitright = true
vim.o.splitbelow = true

-- Cool sets and options
vim.o.number = true
vim.o.scrolloff = 6

-- Show dots for trailing spaces
vim.o.list = true
vim.opt.listchars:append { trail = "•" }

-- Indent blankline glitches a bit, so this helps not making it so visible.
vim.opt.listchars:append { tab = "▎ " }

-- Persistent undo
vim.o.undofile = true

-- Tab key stuff
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Use {{{}}} :D
vim.o.foldmethod = "marker"

-- Much nicer
vim.o.autoindent = true

-- Stop the thing from popping in and out
vim.o.signcolumn = "yes:1"

-- Highlight line number
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- Sync with selection clipboard
vim.o.clipboard = "unnamed"

-- Do case sensitive if any cases, not otherwise.
vim.o.ignorecase = true
vim.o.smartcase = true

-- For fancy text seeing.
vim.o.conceallevel = 2

-- Disable intro message
-- I like it, but some plugin (probably lualine) redraws the screen which makes it flicker.
vim.opt.shortmess:append "I"

-- Hide mode
-- Lualine shows the mode, so it's redundant
vim.o.showmode = false
