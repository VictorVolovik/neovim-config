-- Defaults
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set clipboard^=unnamed,unnamedplus")
vim.g.mapleader = " "

-- Search settings
vim.cmd("set ignorecase")
vim.cmd("set smartcase")

-- Key mappings --
-- add simple hightlight removal
vim.cmd("nmap <Leader><space> :nohlsearch<CR>")

