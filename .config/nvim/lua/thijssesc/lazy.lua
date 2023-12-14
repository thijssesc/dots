-- lazy

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')

vim.keymap.nnoremap { '<leader>uc', lazy.clean }
vim.keymap.nnoremap { '<leader>ui', lazy.install }
vim.keymap.nnoremap { '<leader>up', lazy.profile }
vim.keymap.nnoremap { '<leader>us', lazy.sync }
vim.keymap.nnoremap { '<leader>uu', lazy.update }

lazy.setup({
    require('thijssesc.plugins.blanket'),
    require('thijssesc.plugins.cmp'),
    require('thijssesc.plugins.colorscheme'),
    require('thijssesc.plugins.comment'),
    require('thijssesc.plugins.dap'),
    require('thijssesc.plugins.dressing'),
    require('thijssesc.plugins.gitsigns'),
    require('thijssesc.plugins.harpoon'),
    require('thijssesc.plugins.indentline'),
    require('thijssesc.plugins.jdtls'),
    require('thijssesc.plugins.lsp'),
    require('thijssesc.plugins.lualine'),
    require('thijssesc.plugins.mason'),
    require('thijssesc.plugins.neogen'),
    require('thijssesc.plugins.neotest'),
    require('thijssesc.plugins.null_ls'),
    require('thijssesc.plugins.telescope'),
    require('thijssesc.plugins.tree'),
    require('thijssesc.plugins.treesitter'),
    require('thijssesc.plugins.virtcolumn'),
}, {
    defaults = { lazy = true },
    install = {
        colorscheme = { 'catppuccin' },
    },
    performance = {
       rtp = {
          disabled_plugins = {
             '2html_plugin',
             'bugreport',
             'compiler',
             'ftplugin',
             'getscript',
             'getscriptPlugin',
             'gzip',
             'logipat',
             'matchit',
             'matchparen',
             'netrw',
             'netrwFileHandlers',
             'netrwPlugin',
             'netrwSettings',
             'optwin',
             'rplugin',
             'rrhelper',
             'spellfile_plugin',
             'synmenu',
             'syntax',
             'tar',
             'tarPlugin',
             'tohtml',
             'tutor',
             'vimball',
             'vimballPlugin',
             'zip',
             'zipPlugin',
          },
       },
    },
})
