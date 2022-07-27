-- keymaps

local utils = require('thijssesc.utils')

vim.g.mapleader = ' '

-- reload config
vim.keymap.nnoremap { '<leader>rr', utils.reload }

-- stop the search highlighting if enabled
vim.keymap.nnoremap { '<leader>nh', ':set nohlsearch<CR>' }

-- paste from clipboard
vim.keymap.noremap { { 'n', 'v' }, '<leader>p', '"+p' }
vim.keymap.noremap { { 'n', 'v' }, '<leader>P', '"+P' }
-- copy (file) to clipboard
vim.keymap.noremap { { 'n', 'v' }, '<leader>y', '"+y' }
vim.keymap.noremap { { 'n', 'v' }, '<leader>Y', 'gg"+yG' }

-- unmap arrow keys
vim.keymap.nnoremap { '<Dowp>', '<Nop>' }
vim.keymap.nnoremap { '<Left>', '<Nop>' }
vim.keymap.nnoremap { '<Right>', '<Nop>' }
vim.keymap.nnoremap { '<Up>', '<Nop>' }

-- auto-center
vim.keymap.nnoremap { 'G', 'Gzz' }
vim.keymap.nnoremap { 'n', 'nzz' }
vim.keymap.nnoremap { 'N', 'Nzz' }

-- sorting
vim.keymap.nnoremap { '<leader>so', [[vip:'<,'>sort ui<CR>]] }

-- spell-checking
vim.keymap.nnoremap { '<leader>se', ':setlocal spell! spelllang=en_us<CR>' }
vim.keymap.nnoremap { '<leader>sn', ':setlocal spell! spelllang=nl_nl<CR>' }

-- switch buffers
vim.keymap.nnoremap { '<C-h>', '<C-w>h' }
vim.keymap.nnoremap { '<C-j>', '<C-w>j' }
vim.keymap.nnoremap { '<C-k>', '<C-w>k' }
vim.keymap.nnoremap { '<C-l>', '<C-w>l' }

-- resize splits
vim.keymap.nnoremap { '<A-C-h>', ':vertical resize -2<CR>' }
vim.keymap.nnoremap { '<A-C-j>', ':resize +2<CR>' }
vim.keymap.nnoremap { '<A-C-k>', ':resize -2<CR>' }
vim.keymap.nnoremap { '<A-C-l>', ':vertical resize +2<CR>' }

-- easy switching from/into terminal buffers
vim.keymap.tnoremap { '<C-n>', [[<C-\><C-n>]] }
vim.keymap.tnoremap { '<C-w>', [[<C-\><C-n><C-w>]] }
vim.keymap.tnoremap { '<C-h>', [[<C-\><C-n><C-w>h]] }
vim.keymap.tnoremap { '<C-j>', [[<C-\><C-n><C-w>j]] }
vim.keymap.tnoremap { '<C-k>', [[<C-\><C-n><C-w>k]] }
vim.keymap.tnoremap { '<C-l>', [[<C-\><C-n><C-w>l]] }
vim.keymap.tnoremap { '<C-d>', [[<C-\><C-n><C-w>:q<CR>]] }

-- I hate this
vim.keymap.nnoremap { 'q:', '<Nop>' }

-- cycle through qflist and location list
vim.keymap.nnoremap { ']q', ':cnext<CR>' }
vim.keymap.nnoremap { '[q', ':cprev<CR>' }
vim.keymap.nnoremap { ']l', ':lnext<CR>' }
vim.keymap.nnoremap { '[l', ':lprev<CR>' }
