-- Defaults
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set clipboard^=unnamed,unnamedplus")
vim.g.mapleader = " "

-- Search settings
vim.cmd("set ignorecase")
vim.cmd("set smartcase")

-- Key mappings --
-- add simple hightlight removal
vim.cmd("nmap <Leader><space> :nohlsearch<CR>")

-- Move vertically by visual line
vim.cmd("nnoremap j gj")
vim.cmd("nnoremap k gk")

-- Easy window navigation
vim.cmd("nmap <C-J> <C-W><C-J>")
vim.cmd("nmap <C-K> <C-W><C-K>")
vim.cmd("nmap <C-H> <C-W><C-H>")
vim.cmd("nmap <C-L> <C-W><C-L>")

-- Moving between buffers
vim.cmd("nnoremap <Leader>bg :buffers<CR>:buffer<Space>")
vim.cmd("nnoremap <PageUp>   :bprevious<CR>")
vim.cmd("nnoremap <PageDown> :bnext<CR>")
vim.cmd("nnoremap <Delete> :bdelete<CR>")

--- Moving between tabs
vim.cmd("nmap <Leader><PageUp> :tabp<cr>")
vim.cmd("nmap <Leader><PageDown> :tabn<cr>")

-- Fix nvim hadling new line with * selector in css --
vim.api.nvim_create_autocmd("FileType", {
  pattern = "css",
  callback = function()
    -- @see :help fo-table
    vim.opt_local.formatoptions:remove({ 'r' })
  end,
})
