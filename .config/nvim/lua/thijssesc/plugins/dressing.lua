-- dressing

local M = {
    'stevearc/dressing.nvim',
    name = 'dressing',
    version = '*',
    event = 'VeryLazy',
}

M.opts = {
    input = {
        enabled = true,
        win_options = {
            winblend = 0,
        },
    },
    select = {
        enabled = true
    },
}

return M
