-- neogen

local M = {
    'danymat/neogen',
    name = 'neogen',
    version = '*',
}

M.dependencies = {
    'nvim-treesitter/nvim-treesitter',
}

M.opts = {
    enabled = true
}

M.keys = {
    { '<leader>nf', [[<cmd>lua require('neogen').generate()<CR>]] }
}

return M
