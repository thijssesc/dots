-- virt-column

local M = {
    'lukas-reineke/virt-column.nvim',
    name = 'virt-column',
    version = '*',
    event = { 'BufReadPost', 'BufNewFile' },
}

M.opts = {
    virtcolumn = '|'
}

return M

