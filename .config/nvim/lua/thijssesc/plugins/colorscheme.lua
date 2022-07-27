-- theming

local catppuccin = require('catppuccin')
local colors = require('catppuccin.api.colors')
local cp = colors.get_colors()

catppuccin.setup {
    transparent_background = true,
    integrations = {
        nvimtree = {
            transparent_panel = true,
        },
    },
}

vim.g.catppuccin_flavour = 'macchiato'
vim.cmd.colorscheme('catppuccin')

-- general highlighting stuff
vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE', fg = 'NONE', underline = true })
vim.api.nvim_set_hl(0, 'QuickFixLine', { bg = 'NONE', fg = cp.flamingo, underline = true })

-- lsp cursor hold highlighting
vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = 'NONE', fg = 'NONE', bold = true, underline = true })
vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = 'NONE', fg = 'NONE', bold = true, underline = true })
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = 'NONE', fg = 'NONE', bold = true, underline = true })

-- telescope stuff
vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = 'NONE', fg = 'NONE', bold = true, underline = true })

-- nvimtree stuff
vim.api.nvim_set_hl(0, 'NvimTreeVertSplit', { bg = 'NONE', fg = cp.base })
