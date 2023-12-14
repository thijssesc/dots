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

local keymap_opts = { silent = true, noremap = true }
vim.keymap.set('n', '<leader>uc', lazy.clean, keymap_opts)
vim.keymap.set('n', '<leader>ui', lazy.install, keymap_opts)
vim.keymap.set('n', '<leader>up', lazy.profile, keymap_opts)
vim.keymap.set('n', '<leader>us', lazy.sync, keymap_opts)
vim.keymap.set('n', '<leader>uu', lazy.update, keymap_opts)

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
