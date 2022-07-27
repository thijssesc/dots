-- packer

local packer = require('packer')

vim.keymap.nnoremap { '<leader>uc', packer.clean }
vim.keymap.nnoremap { '<leader>uC', packer.compile }
vim.keymap.nnoremap { '<leader>ui', packer.install }
vim.keymap.nnoremap { '<leader>us', packer.sync }
vim.keymap.nnoremap { '<leader>uu', packer.update }
